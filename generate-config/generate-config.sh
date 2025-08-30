#!/bin/bash

# generate-config.sh
# Script to generate localized AIOStreams configurations
# Usage: ./generate-config.sh [locale]
# Example: ./generate-config.sh french

set -e

# Default values
LOCALE=${1:-"french"}
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARENT_DIR="$(dirname "$SCRIPT_DIR")"
BASE_CONFIG="$PARENT_DIR/aiostreams-config.json"
LOCALE_CONFIG="$SCRIPT_DIR/${LOCALE}.json"
OUTPUT_CONFIG="$PARENT_DIR/aiostreams-config-${LOCALE}.json"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if required files exist
if [ ! -f "$BASE_CONFIG" ]; then
    print_error "Base configuration file '$BASE_CONFIG' not found!"
    exit 1
fi

if [ ! -f "$LOCALE_CONFIG" ]; then
    print_error "Locale configuration file '$LOCALE_CONFIG' not found!"
    exit 1
fi

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    print_error "jq is required but not installed. Please install jq first."
    echo "On Ubuntu/Debian: sudo apt-get install jq"
    echo "On macOS: brew install jq"
    exit 1
fi

print_status "Generating ${LOCALE} configuration..."
print_status "Base config: $BASE_CONFIG"
print_status "Locale config: $LOCALE_CONFIG"
print_status "Output: $OUTPUT_CONFIG"

# Create a temporary file for processing
TMP_FILE=$(mktemp)

# Start with the base configuration
cp "$BASE_CONFIG" "$TMP_FILE"
# Always extract sortCriteria from the base config and assign it directly
BASE_SORTCRITERIA=$(jq '.sortCriteria' "$BASE_CONFIG")
TMP_FILE2=$(mktemp)
jq --argjson baseSortCriteria "$BASE_SORTCRITERIA" '.sortCriteria = $baseSortCriteria' "$TMP_FILE" > "$TMP_FILE2"
mv "$TMP_FILE2" "$TMP_FILE"

# Read locale-specific configuration, but strip sortCriteria if present
LOCALE_DATA=$(jq 'del(.sortCriteria)' "$LOCALE_CONFIG")

# Extract components from locale config
SUBTITLE_LANG_MAPPING=$(echo "$LOCALE_DATA" | jq -r '.subtitleLanguageMapping // {}')
EXCLUDED_PRESETS=$(echo "$LOCALE_DATA" | jq -r '.excludedPresets // []')
EXCLUDED_CATALOGS=$(echo "$LOCALE_DATA" | jq -r '.excludedCatalogs // []')
MODIFIED_PRESETS=$(echo "$LOCALE_DATA" | jq -r '.modifiedPresets // []')
ADDITIONAL_PRESETS=$(echo "$LOCALE_DATA" | jq -r '.additionalPresets // []')
ADDITIONAL_CATALOGS=$(echo "$LOCALE_DATA" | jq -r '.additionalCatalogs // []')

CATALOG_REPLACEMENTS=$(echo "$LOCALE_DATA" | jq -r '.catalogReplacements // []')
COUNTRY_SPECIFIC=$(echo "$LOCALE_DATA" | jq -r '.countrySpecific // {}')

# Extract preferredLanguages if present
PREFERRED_LANGS=$(echo "$LOCALE_DATA" | jq -c '.languagePreferences.preferredLanguages // empty')
# Extract sortCriteriaLanguagePosition if present
SORT_CRITERIA_LANG_POS=$(echo "$LOCALE_DATA" | jq -c '.sortCriteriaLanguagePosition // empty')
# Function to replace catalogModifications entries as specified in catalogReplacements
replace_catalog_modifications() {
        if [ "$CATALOG_REPLACEMENTS" != "[]" ] && [ "$CATALOG_REPLACEMENTS" != "null" ]; then
                print_status "Applying catalog replacements..."
                echo "$CATALOG_REPLACEMENTS" | jq -c '.[]' | while read -r replacement; do
                        MATCH_ID=$(echo "$replacement" | jq -r '.match.id')
                        MATCH_NAME=$(echo "$replacement" | jq -r '.match.name')
                        REPLACE_ID=$(echo "$replacement" | jq -r '.replace.id')
                        REPLACE_NAME=$(echo "$replacement" | jq -r '.replace.name')
                        TMP_FILE2=$(mktemp)
                        # Replace in catalogModifications array
                        jq --arg matchId "$MATCH_ID" --arg matchName "$MATCH_NAME" --arg replaceId "$REPLACE_ID" --arg replaceName "$REPLACE_NAME" '
                                if .catalogModifications then
                                    .catalogModifications = (.catalogModifications | map(
                                        if (.id == $matchId and .name == $matchName) then
                                            .id = $replaceId | .name = $replaceName
                                        else . end
                                    ))
                                else . end
                        ' "$TMP_FILE" > "$TMP_FILE2"
                        mv "$TMP_FILE2" "$TMP_FILE"
                done
        fi
}

# Não há mais lógica de languagePreferences/languages/languageReplacements

# Function to update subtitle addon languages
update_subtitle_languages() {
    if [ "$SUBTITLE_LANG_MAPPING" != "{}" ] && [ "$SUBTITLE_LANG_MAPPING" != "null" ]; then
        print_status "Updating subtitle addon languages..."
        
        # For each subtitle addon mapping
        echo "$SUBTITLE_LANG_MAPPING" | jq -r 'keys[]' | while read -r addon_name; do
            if [ -n "$addon_name" ]; then
                print_status "  - Updating languages for: $addon_name"
                
                # Get the language configuration for this addon
                ADDON_LANG_CONFIG=$(echo "$SUBTITLE_LANG_MAPPING" | jq -c --arg name "$addon_name" '.[$name]')
                
                # For each language property in the addon config
                echo "$ADDON_LANG_CONFIG" | jq -r 'keys[]' | while read -r lang_property; do
                    if [ -n "$lang_property" ]; then
                        NEW_LANGUAGES=$(echo "$ADDON_LANG_CONFIG" | jq -c --arg prop "$lang_property" '.[$prop]')
                        
                        TMP_FILE2=$(mktemp)
                        jq --arg addonName "$addon_name" --arg langProp "$lang_property" --argjson newLangs "$NEW_LANGUAGES" '
                            .presets = (.presets | map(
                                if .options.name == $addonName then
                                    .options[$langProp] = $newLangs
                                else . end
                            ))' "$TMP_FILE" > "$TMP_FILE2"
                        mv "$TMP_FILE2" "$TMP_FILE"
                    fi
                done
            fi
        done
    fi
}

# Function to remove excluded presets
remove_excluded_presets() {
    if [ "$EXCLUDED_PRESETS" != "[]" ] && [ "$EXCLUDED_PRESETS" != "null" ]; then
        print_status "Removing excluded presets..."
        
        # Extract the names of presets to exclude
        EXCLUDED_NAMES=$(echo "$EXCLUDED_PRESETS" | jq -r '.[].name')
        
        # For each excluded name, remove the preset from the presets array
        while IFS= read -r excluded_name; do
            if [ -n "$excluded_name" ]; then
                print_status "  - Excluding: $excluded_name"
                TMP_FILE2=$(mktemp)
                jq --arg excludeName "$excluded_name" '.presets = (.presets | map(select(.options.name != $excludeName)))' "$TMP_FILE" > "$TMP_FILE2"
                mv "$TMP_FILE2" "$TMP_FILE"
            fi
        done <<< "$EXCLUDED_NAMES"
    fi
}

# Function to remove excluded catalogs
remove_excluded_catalogs() {
    if [ "$EXCLUDED_CATALOGS" != "[]" ] && [ "$EXCLUDED_CATALOGS" != "null" ]; then
        print_status "Removing excluded catalogs..."
        
        # Extract the addon names of catalogs to exclude
        EXCLUDED_ADDON_NAMES=$(echo "$EXCLUDED_CATALOGS" | jq -r '.[].addonName')
        
        # For each excluded addon name, remove catalogs from both catalogs and catalogModifications arrays
        while IFS= read -r excluded_addon_name; do
            if [ -n "$excluded_addon_name" ]; then
                print_status "  - Excluding catalogs from: $excluded_addon_name"
                TMP_FILE2=$(mktemp)
                
                # Remove from catalogs array if it exists
                if jq -e '.catalogs' "$TMP_FILE" > /dev/null; then
                    jq --arg excludeAddonName "$excluded_addon_name" '.catalogs = (.catalogs | map(select(.addonName != $excludeAddonName)))' "$TMP_FILE" > "$TMP_FILE2"
                    mv "$TMP_FILE2" "$TMP_FILE"
                fi
                
                # Remove from catalogModifications array if it exists
                if jq -e '.catalogModifications' "$TMP_FILE" > /dev/null; then
                    TMP_FILE2=$(mktemp)
                    jq --arg excludeAddonName "$excluded_addon_name" '.catalogModifications = (.catalogModifications | map(select(.addonName != $excludeAddonName)))' "$TMP_FILE" > "$TMP_FILE2"
                    mv "$TMP_FILE2" "$TMP_FILE"
                fi
            fi
        done <<< "$EXCLUDED_ADDON_NAMES"
    fi
}

# Function to modify existing presets
modify_existing_presets() {
    if [ "$MODIFIED_PRESETS" != "[]" ] && [ "$MODIFIED_PRESETS" != "null" ]; then
        print_status "Modifying existing presets..."
        echo "$MODIFIED_PRESETS" | jq -c '.[]' | while read -r preset_mod; do
            PRESET_NAME=$(echo "$preset_mod" | jq -r '.name')
            PRESET_OPTIONS=$(echo "$preset_mod" | jq -c '.options')
            if [ -n "$PRESET_NAME" ] && [ "$PRESET_OPTIONS" != "null" ]; then
                print_status "  - Modifying preset: $PRESET_NAME"
                # For each key in options
                echo "$PRESET_OPTIONS" | jq -r 'keys[]' | while read -r option_key; do
                    # Get the value as raw JSON (not string)
                    option_value=$(echo "$PRESET_OPTIONS" | jq -c --arg key "$option_key" '.[$key]')
                    TMP_FILE2=$(mktemp)
                    jq --arg presetName "$PRESET_NAME" --arg optionKey "$option_key" --argjson optionValue "$option_value" '
                        .presets = (.presets | map(
                            if .options.name == $presetName then
                                .options[$optionKey] = $optionValue
                            else . end
                        ))' "$TMP_FILE" > "$TMP_FILE2"
                    mv "$TMP_FILE2" "$TMP_FILE"
                done
            fi
        done
    fi
}

# Function to add additional presets
add_additional_presets() {
    if [ "$ADDITIONAL_PRESETS" != "[]" ] && [ "$ADDITIONAL_PRESETS" != "null" ]; then
        print_status "Adding additional presets..."
        TMP_FILE2=$(mktemp)
        jq --argjson additionalPresets "$ADDITIONAL_PRESETS" '.presets += $additionalPresets' "$TMP_FILE" > "$TMP_FILE2"
        mv "$TMP_FILE2" "$TMP_FILE"
    fi
}

# Function to add additional catalogs (no longer creates top-level catalogs array)
add_additional_catalogs() {
    if [ "$ADDITIONAL_CATALOGS" != "[]" ] && [ "$ADDITIONAL_CATALOGS" != "null" ]; then
        print_status "Adding additional catalogs... (skipped, not adding top-level catalogs)"
        # No-op: catalogs are not added as a top-level array anymore
        :
    fi
}

# Function to add country-specific settings (no longer adds countrySpecific)
add_country_specific() {
    # No-op: countrySpecific is not added anymore
    :
}



# Perform all merging operations
update_subtitle_languages
remove_excluded_presets
remove_excluded_catalogs
modify_existing_presets
add_additional_presets
add_additional_catalogs
replace_catalog_modifications
add_country_specific

# Overwrite preferredLanguages if defined in locale config
if [ "$PREFERRED_LANGS" != "" ] && [ "$PREFERRED_LANGS" != "null" ]; then
    print_status "Overriding preferredLanguages from locale config..."
    TMP_FILE2=$(mktemp)
    jq --argjson prefLangs "$PREFERRED_LANGS" '.preferredLanguages = $prefLangs' "$TMP_FILE" > "$TMP_FILE2"
    mv "$TMP_FILE2" "$TMP_FILE"
fi

# Overwrite sortCriteria order for language if defined in locale config
if [ "$SORT_CRITERIA_LANG_POS" != "" ] && [ "$SORT_CRITERIA_LANG_POS" != "null" ]; then
    print_status "Adjusting sortCriteria language position from locale config..."
        # Overwrite the entire sortCriteria object with a valid one from the base config
        TMP_FILE2=$(mktemp)
        jq --argjson baseSortCriteria "$(jq '.sortCriteria' "$BASE_CONFIG")" '.sortCriteria = $baseSortCriteria' "$TMP_FILE" > "$TMP_FILE2"
        mv "$TMP_FILE2" "$TMP_FILE"
        # Now apply the language position logic for each key
        for key in cached uncached; do
            pos=$(echo "$SORT_CRITERIA_LANG_POS" | jq -r --arg k "$key" '.[$k] // empty')
            if [ "$pos" != "" ]; then
                before_key=$(echo "$pos" | awk -F: '{print $2}')
                TMP_FILE2=$(mktemp)
                jq --arg key "$key" --arg beforeKey "$before_key" '
                    .sortCriteria[$key] = (
                      (.sortCriteria[$key] | map(select(type == "object" and .key? != null and .key != "language")))
                      | (reduce range(0; length) as $i ([]; . + (if .[$i].key == $beforeKey then [{"key":"language","direction":"desc"}, .[$i]] else [.[$i]] end)))
                    )
                ' "$TMP_FILE" > "$TMP_FILE2"
                mv "$TMP_FILE2" "$TMP_FILE"
            fi
        done
fi

# Não é mais necessário remover campos, pois não são mais gerados

# Validate the resulting JSON
if jq empty "$TMP_FILE" 2>/dev/null; then
    print_status "JSON validation successful"
else
    print_error "Generated JSON is invalid!"
    rm "$TMP_FILE"
    exit 1
fi

# Move the final result to output file
mv "$TMP_FILE" "$OUTPUT_CONFIG"

print_status "✅ Successfully generated '$OUTPUT_CONFIG'"
print_status "Configuration includes:"

# Show what was added/removed
if [ "$LANG_PREFS" != "" ] && [ "$LANG_PREFS" != "null" ]; then
    echo "  • Language preferences"
fi

if [ "$SUBTITLE_LANG_MAPPING" != "{}" ] && [ "$SUBTITLE_LANG_MAPPING" != "null" ]; then
    SUBTITLE_ADDON_COUNT=$(echo "$SUBTITLE_LANG_MAPPING" | jq 'keys | length')
    echo "  • $SUBTITLE_ADDON_COUNT subtitle addons updated"
fi

if [ "$EXCLUDED_PRESETS" != "[]" ] && [ "$EXCLUDED_PRESETS" != "null" ]; then
    EXCLUDED_COUNT=$(echo "$EXCLUDED_PRESETS" | jq '. | length')
    echo "  • $EXCLUDED_COUNT presets excluded"
fi

if [ "$EXCLUDED_CATALOGS" != "[]" ] && [ "$EXCLUDED_CATALOGS" != "null" ]; then
    EXCLUDED_CAT_COUNT=$(echo "$EXCLUDED_CATALOGS" | jq '. | length')
    echo "  • $EXCLUDED_CAT_COUNT catalog groups excluded"
fi

if [ "$MODIFIED_PRESETS" != "[]" ] && [ "$MODIFIED_PRESETS" != "null" ]; then
    MODIFIED_COUNT=$(echo "$MODIFIED_PRESETS" | jq '. | length')
    echo "  • $MODIFIED_COUNT presets modified"
fi

if [ "$ADDITIONAL_PRESETS" != "[]" ] && [ "$ADDITIONAL_PRESETS" != "null" ]; then
    PRESET_COUNT=$(echo "$ADDITIONAL_PRESETS" | jq '. | length')
    echo "  • $PRESET_COUNT additional presets"
fi

if [ "$ADDITIONAL_CATALOGS" != "[]" ] && [ "$ADDITIONAL_CATALOGS" != "null" ]; then
    CATALOG_COUNT=$(echo "$ADDITIONAL_CATALOGS" | jq '. | length')
    echo "  • $CATALOG_COUNT additional catalogs"
fi

if [ "$COUNTRY_SPECIFIC" != "{}" ] && [ "$COUNTRY_SPECIFIC" != "null" ]; then
    echo "  • Country-specific settings"
fi

print_status "🎉 Generation complete!"
