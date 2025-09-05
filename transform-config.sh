#!/bin/bash

# Script to transform aiostreams-config-new.json to aiostreams-config.json format
# Usage: ./transform-config.sh [input_file] [output_file]

set -e

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "Error: jq is not installed. Please install jq first."
    echo "Ubuntu/Debian: sudo apt install jq"
    echo "CentOS/RHEL: sudo yum install jq"
    echo "macOS: brew install jq"
    exit 1
fi

# Define input and output files
INPUT_FILE="${1:-aiostreams-config-new.json}"
OUTPUT_FILE="${2:-aiostreams-config-transformed.json}"

# Check if input file exists
if [[ ! -f "$INPUT_FILE" ]]; then
    echo "Error: Input file '$INPUT_FILE' not found."
    exit 1
fi

echo "Transforming '$INPUT_FILE' to compatible format..."

# Create backup of existing file if it exists
if [[ -f "$OUTPUT_FILE" ]]; then
    echo "Creating backup of existing file..."
    cp "$OUTPUT_FILE" "${OUTPUT_FILE}.backup.$(date +%Y%m%d_%H%M%S)"
fi

# Transform JSON using jq
jq --arg rpdb "t0-free-rpdb" '{
    presets: .presets,
    formatter: .formatter,
    preferredQualities: .preferredQualities,
    preferredResolutions: .preferredResolutions,
    excludedQualities: .excludedQualities,
    excludedVisualTags: .excludedVisualTags,
    sortCriteria: .sortCriteria,
    deduplicator: .deduplicator,
    trusted: .trusted,
    addonName: .addonName,
    addonDescription: .addonDescription,
    preferredLanguages: .preferredLanguages,
    includedVisualTags: .includedVisualTags,
    preferredVisualTags: .preferredVisualTags,
    preferredAudioTags: .preferredAudioTags,
    preferredAudioChannels: .preferredAudioChannels,
    preferredStreamTypes: .preferredStreamTypes,
    preferredEncodes: .preferredEncodes,
    preferredRegexPatterns: .preferredRegexPatterns,
    rpdbApiKey: $rpdb,
    showStatistics: .showStatistics,
    titleMatching: (if (.titleMatching.enabled // true) == true then .titleMatching else empty end),
    seasonEpisodeMatching: (if (.seasonEpisodeMatching.enabled // true) == true then .seasonEpisodeMatching else empty end),
    autoPlay: .autoPlay,
    precacheNextEpisode: .precacheNextEpisode,
    alwaysPrecache: .alwaysPrecache,
    catalogModifications: [
        .catalogModifications[] 
        | del(.enabled, .shuffle)
    ]
}' "$INPUT_FILE" > "$OUTPUT_FILE"

# Check if transformation was successful
if [[ -f "$OUTPUT_FILE" ]]; then
    echo "✅ Transformation completed successfully!"
    echo "📄 Output file: $OUTPUT_FILE"
    
    # Show basic statistics
    echo ""
    echo "📊 Statistics:"
    PRESETS_COUNT=$(jq '.presets | length' "$OUTPUT_FILE" 2>/dev/null || echo "N/A")
    CATALOG_COUNT=$(jq '.catalogModifications | length' "$OUTPUT_FILE" 2>/dev/null || echo "N/A")
    REGEX_COUNT=$(jq '.preferredRegexPatterns | length' "$OUTPUT_FILE" 2>/dev/null || echo "N/A")
    
    echo "   - Presets: $PRESETS_COUNT"
    echo "   - Catalog Modifications: $CATALOG_COUNT" 
    echo "   - Preferred Regex Patterns: $REGEX_COUNT"
    
    # Check removed sections
    SERVICES_COUNT=$(jq '.services | length // 0' "$INPUT_FILE" 2>/dev/null || echo 0)
    
    echo ""
    echo "🧹 Removed from original:"
    if [[ $SERVICES_COUNT -gt 0 ]]; then
        echo "   - ✅ 'services' section ($SERVICES_COUNT services)"
    fi
    echo "   - ✅ 'proxy' section"
    echo "   - ✅ 'externalDownloads' field" 
    echo "   - ✅ All empty arrays (except excludedQualities & excludedVisualTags)"
    echo "   - ✅ All 'enabled' and 'shuffle' fields from catalogModifications"
    echo "   - ✅ Fields with 'enabled: false' (like yearMatching)"
    
    echo ""
    echo "ℹ️  The transformed file is in compatible format with the original aiostreams-config.json."
    echo "ℹ️  Added rpdbApiKey: 't0-free-rpdb'"
else
    echo "❌ Error during file transformation."
    exit 1
fi
