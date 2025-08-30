# AIOStreams Configuration

<img width="2880" height="1800" alt="image" src="https://github.com/user-attachments/assets/71f73d6c-365d-4390-8149-eadfa4eaaf63" />

## 📋 Overview


This is a custom **[AIOStreams](https://github.com/Viren070/AIOStreams)** configuration for **[Stremio](https://www.stremio.com/)**, optimized for Portuguese and English content with a focus on high quality. The configuration uses Real-Debrid as the primary debrid service and includes a carefully selected collection of addons for maximum compatibility and quality.

## 🆕 What's New (updated: 2025-08-30)

- The main configuration file, `aiostreams-config.json`, is now highly optimized: it is as small as possible and only contains what is strictly necessary for the best experience. All localized configurations are generated from this main file, ensuring minimal and maintainable outputs.
- The configuration generator script (`generate-config.sh`) always writes the generated file to the repository root using the pattern `aiostreams-config-<locale>.json` (for example, `aiostreams-config-french.json`).
- You can easily generate localized configurations (for French, Brazilian Portuguese, etc.) from the main config by running the script with the desired locale. Example:
  ```bash
  ./generate-config/generate-config.sh french
  # or, from the root:
  ./generate-config.sh french
  ```
- In extra addons, the protocol `stremio://` is used instead of `https://` for manifest URLs, as it was found to be faster and more reliable in Stremio.
- The configuration leverages the **Rating Poster DataBase (rpdb)** for enhanced poster and rating metadata, improving the browsing and selection experience.

### 🔗 Related Projects
- **[AIOStreams](https://github.com/Viren070/AIOStreams)** - Advanced Stremio addon aggregator
- **[Stremio](https://www.stremio.com/)** - Modern media center and streaming platform

### 🙏 Credits

This configuration is **based on and inspired by** the excellent work of **[Tamtaro](https://discord.com/channels/1225024298490662974/1391478569607368924)** from the AIOStreams Discord community. The original configuration has been adapted and optimized for Portuguese/English content with additional customizations for public sharing.

**Special thanks to Tamtaro** for creating the foundation that made this configuration possible!

**Stream expressions and regex patterns** are sourced from **[Vidhin05/Releases-Regex](https://github.com/Vidhin05/Releases-Regex)**, providing comprehensive and up-to-date release group classifications for quality filtering.

## Available Versions

This repository provides **four configuration versions** to suit different language preferences:

### 🇵🇹 English + Portuguese Version
- **File**: [`aiostreams-config.json`](./aiostreams-config.json) (main configuration)
- **Content**: Full configuration with both English and Portuguese addons
- **Includes**: Tugaflix, TugaKids, Reflux, Minha TV, TvVoo and other Portuguese content sources
- **Best for**: Users who want access to both English and Portuguese content

### 🇧🇷 Brazilian Portuguese + English Version
- **File**: [`aiostreams-config-brazilian-portuguese.json`](./aiostreams-config-brazilian-portuguese.json)
- **Content**: Configuration optimized for Brazilian Portuguese content with English support
- **Includes**: Brazuca Torrents, Reflux, Tugaflix, Brazilian subtitle support (PT-BR), and TvVoo disabled
- **Language Priority**: Portuguese first, then English
- **Best for**: Brazilian users who prefer Portuguese content but want English as backup

### 🇺🇸 English Only Version  
- **File**: [`aiostreams-config-english-only.json`](./aiostreams-config-english-only.json)
- **Content**: Streamlined configuration with only English language addons
- **Excludes**: Portuguese-specific addons (Tugaflix, TugaKids, Reflux, Portuguese TV channels)
- **Best for**: Users who only consume English content and prefer a cleaner setup

### 🇫🇷 English + French Version
- **File**: [`aiostreams-config-french.json`](./aiostreams-config-french.json)
- **Content**: Configuration optimized for English and French content
- **Includes**: TvVoo (France + UK), French subtitle support, and French torrent sources
- **Best for**: French-speaking users who want both English and French content


All versions include the same high-quality streaming addons (Torrentio, Comet, MediaFusion, etc.) and quality preferences, differing only in language-specific content sources and subtitle configurations.

## ⚡ Technical Optimizations

- **stremio:// protocol for addons:** All extra addon manifests use the `stremio://` protocol instead of `https://` for faster and more reliable loading in Stremio. This improves startup speed and reduces manifest fetch issues.
- **Rating Poster DataBase (rpdb):** The configuration leverages the Rating Poster DataBase (rpdb) to provide enhanced poster images and rating metadata, improving the browsing and selection experience in Stremio.

## 🔐 Debrid Services

### Enabled
- **[Real-Debrid](https://real-debrid.com/)** ✅ - Primary service for converting torrents to direct links

### Available (Disabled)
- [AllDebrid](https://alldebrid.com/), [Premiumize](https://premiumize.me/), [DebridLink](https://debrid-link.com/), [TorBox](https://torbox.app/), [OffCloud](https://offcloud.com/), [Put.io](https://put.io/), EasyNews, EasyDebrid, Debrider, [PikPak](https://mypikpak.com/), [Seedr](https://seedr.cc/)

## 🎯 Configured Addons

### 📺 Main Streaming Addons

#### **[Torrentio](https://torrentio.strem.fun/)** 
- **Status**: ✅ Enabled
- **Resources**: Stream, Catalog, Meta
- **Description**: Primary addon for torrent search with multiple instances support

#### **[Comet](https://comet.fast)**
- **Status**: ✅ Enabled  
- **Resources**: Stream
- **Configuration**: 
  - Include P2P: Yes
- **Description**: Stream aggregator with intelligent filtering

#### **[MediaFusion](https://mediafusion.elfhosted.com/)**
- **Status**: ✅ Enabled
- **Resources**: Stream, Catalog, Meta  
- **Timeout**: 5000ms (optimized for speed)
- **Description**: Streams with enriched metadata

#### **[StremThru Torz](https://stremthru.elfhosted.com/stremio/torz/)**
- **Status**: ✅ Enabled
- **Resources**: Stream
- **Configuration**: P2P enabled, single instance
- **Description**: Torrent stream proxy

#### **[TorrentsDB](https://torrentsdb.com/)**
- **Status**: ✅ Enabled
- **Resources**: Stream, Catalog, Meta
- **Providers**: YTS, 1337x, TPB, RARBG, Nyaa, and 20+ others
- **Description**: Comprehensive torrent database

### 🇵🇹 Portuguese Content Addons

#### **[Tugaflix](https://tugaflix.vercel.app/)**
- **Status**: ✅ Enabled
- **Configuration**: `forceToTop: true` (maximum priority)
- **Description**: High-quality Portuguese content

#### **[TugaKids](https://e1d6cc1ff4a7-tugakids-stremio.baby-beamup.club/configure/)** 
- **Status**: ✅ Enabled
- **Configuration**: `forceToTop: true`
- **Description**: Animation and children's content in PT-PT

#### **[Reflux](https://github.com/Nightfruit/reflux)**
- **Status**: ✅ Enabled
- **Description**: Brazilian catalog with movies and series

#### **[Brazuca Torrents](https://stremio-addons.com/brazuca-torrents.html)**
- **Status**: ✅ Enabled (Portuguese and Brazilian Portuguese versions)
- **Configuration**: `forceToTop: true` (maximum priority on Brazilian version)
- **Description**: Brazilian torrent sources with Portuguese content
- **Content**: Focused on Brazilian Portuguese movies and series

### 🔍 Search and Metadata Addons

#### **Cast Search**
- **Status**: ✅ Enabled
- **Configuration**: `resultPassthrough: true`
- **Description**: Search by cast and crew

#### **[Stremio-addons.net](https://stremio-addons.net/)**
- **Status**: ✅ Enabled
- **Description**: Community addon aggregator

#### **[Sagas and Marathons](https://stremio-addons.net/addons/tvvoo)**
- **Status**: ✅ Enabled
- **Description**: Organized collections and marathons

### 📺 Live TV

#### **[USA TV](https://stremio-addons.com/usa-tv.html)**
- **Status**: ✅ Enabled
- **Resources**: Catalog, Meta, Stream
- **Description**: American TV channels

#### **[Minha TV](https://stremio-addons.net/addons/minha-tv)**
- **Status**: ✅ Enabled
- **Resources**: TV Channels
- **Description**: Portuguese TV channels with live streaming
- **Content**: Portuguese television networks and local channels

#### **[TvVoo](https://stremio-addons.net/addons/tvvoo)**
- **Status**: ✅ Enabled
- **Configuration**: UK + PT regions
- **Resources**: TV Channels
- **Description**: Live TV channels from United Kingdom and Portugal
- **Features**: Multi-region support with Portuguese and British content

### 🎬 Special Content

#### **[Youtubio](https://youtubio.elfhosted.com/)**
- **Status**: ✅ Enabled
- **Description**: YouTube integration for documentaries and special content

### 📝 Subtitle Addons

#### **[SubHero](https://subhero.onrender.com/configure)** ✅
- **Status**: Enabled
- **Languages**: English, Portuguese (PT/BR)
- **Description**: High-quality subtitles

#### **[OpenSubtitles V3+](https://opensubtitles-v3.strem.io/)** ❌
- **Status**: Disabled
- **Reason**: SubHero offers better quality

#### **[SubSource](https://stremio-addons.com/subsource-subtitles.html)** ❌ 
- **Status**: Disabled

#### **[AIOSubtitle](https://stremio-addons.com/aio-substitle.html)** ❌
- **Status**: Disabled

## 🎨 Custom Formatting

The configuration includes a custom formatter that displays:
- **Resolution**: 𝟜𝙺 (2160p), 𝟚𝙺 (1440p), 1080𝕡, etc.
- **Cache Status**: ⚡ (cached), ⏳ (not cached)  
- **Quality**: 🎬 with title and year
- **Technical Info**: 🧪 encode, 🎨 visual tags, 🎵 audio, 🎧 channels
- **Metadata**: 🗄️ size, ⇋ seeders, 🌐/🛡️ proxy status

## 📊 Quality Preferences

### Qualities (Priority Order)
1. **BluRay REMUX** - Maximum quality
2. **BluRay** - High quality  
3. **WEB-DL** - High-quality streaming
4. **WEBRip** - Good web quality
5. HDRip, DVDRip, HDTV, etc.

### Resolutions (Priority Order)  
1. **2160p** (4K)
2. **1440p** (2K)
3. **1080p** (Full HD)
4. **720p** (HD)
5. Lower resolutions

### Preferred Languages
1. **English**
2. **Dual Audio** 
3. **Multi**
4. **Portuguese**
5. Japanese, Korean (for anime)

### Visual Tags (Priority Order)
1. **3D** - 3D content gets highest priority
2. **IMAX** - IMAX enhanced versions prioritized
3. **HDR+DV** - Dolby Vision with HDR (best HDR quality)
4. **HDR10+** - Advanced HDR with dynamic metadata
5. **HDR10** - Standard HDR10
6. **DV** - Dolby Vision standard
7. **DV Only** - Dolby Vision exclusive
8. **HDR** - Generic HDR
9. **HDR Only** - HDR exclusive content
10. **10bit** - 10-bit color depth
11. **AI** - AI-enhanced content
12. **SDR** - Standard Dynamic Range
13. **Unknown** - Unspecified visual quality

## 🎯 Quality Patterns (Regex)

The configuration includes sophisticated regex patterns to classify releases:

### 📋 Source
**Stream expressions and regex patterns** are based on **[Vidhin05/Releases-Regex](https://github.com/Vidhin05/Releases-Regex)**, providing comprehensive and up-to-date release group classifications.

### Anime (Classification T1-T8)
- **T1**: Premium groups (Aergia, smol, SoM, Vodes, Legion)
- **T2**: High-quality groups (Alt, ARC, Lulu, Moxie)
- **T3-T8**: Descending quality classification

### Remux (T1-T3)
- **T1**: Top groups (3L, BiZKiT, BLURANiUM, CiNEPHiLES)
- **T2-T3**: Descending quality

### Web Releases (T1-T3)
- **T1**: Premium groups (ABBIE, PEXA, CMRG, NTb)
- **T2-T3**: Standard quality

### "Bad" Filter
Automatically removes low-quality releases from groups known for poor quality.

## ⚙️ Advanced Settings

### Deduplication
- **Enabled** to avoid duplicate streams
- **Criteria**: filename, infoHash, smartDetect
- **Policy**: single_result for cached/uncached/p2p

### Smart Sorting
- **Cached**: Prioritizes resolution → quality → stream type
- **Uncached**: Prioritizes seeders → resolution → quality

### Proxy
- **MediaFlow** configured for protected streams
- Specific addons and services can be proxied

### AutoPlay
- **Attributes**: service, proxied, resolution, quality, encode, audioTags, visualTags, languages, releaseGroup
- **Precache**: Enabled for next episodes

## 📺 Custom Catalogs

### Portuguese Content
- **Animation in PT-PT** (TugaKids)
- **Reflux Catalog** (Brazilian movies and series)

### Live TV Channels
- **Minha TV** (Portuguese channels)
- **Vavoo TV** (Portugal + UK)
- **USA TV** (American channels)

### Special Content  
- **Marathons & Sagas** (thematic collections)
- **YouTube** (documentaries and special content)
- **Anime Search** (specialized search)

### IPTV
- **IPTV Movies** and **IPTV Channels** enabled
- **USA TV** for American channels

## 🚀 How to Use

### Step 1: Choose Your Configuration
Select the appropriate configuration file based on your language preferences:
- **`aiostreams-config-with-portuguese.json`** - Full configuration with English + Portuguese addons
- **`aiostreams-config-english-only.json`** - Streamlined configuration with English addons only

### Option 1: With Real-Debrid (Recommended)
1. **Import** your chosen configuration file into AIOStreams
<img width="2880" height="1800" alt="image" src="https://github.com/user-attachments/assets/2aa6dbd8-3ebf-4d1e-bc6e-2edc7593fac6" />

2. **Configure** your **[Real-Debrid](https://real-debrid.com/)** credentials in Services
<img width="2880" height="1800" alt="image" src="https://github.com/user-attachments/assets/e04c4649-2507-49a8-a920-3ff977afabcc" />

3. **Install** the resulting addon in Stremio

4. **Enjoy** optimized quality content with instant streaming!

### Option 2: Without Real-Debrid (Free Alternative)
1. **Import** the `aiostreams-config.json` file into AIOStreams
<img width="2880" height="1800" alt="image" src="https://github.com/user-attachments/assets/0de680c8-6073-4b13-aefb-cb24dd840bc7" />

2. **Disable Real-Debrid**
<img width="2880" height="1800" alt="image" src="https://github.com/user-attachments/assets/1e41d81a-6006-434f-a906-31ab889598c4" />

4. **Install** the resulting addon in Stremio

5. **Stream content** using P2P torrents and direct links

#### What works without Real-Debrid:
- ✅ **P2P Torrents** - Direct torrent streaming (requires good internet)
- ✅ **Direct HTTP streams** - From addons like Tugaflix, TugaKids, Reflux
- ✅ **Live TV** - Minha TV, TvVoo, USA TV channels
- ✅ **YouTube content** - Youtubio documentaries and videos
- ✅ **All subtitle addons** - SubHero, etc.
- ✅ **Search and metadata** - Cast Search, Sagas and Marathons

#### Limitations without Real-Debrid:
- ⚠️ **Slower streaming** - P2P depends on seeders and your connection
- ⚠️ **Limited high-quality sources** - Fewer 4K/1080p options
- ⚠️ **No instant playback** - Torrents need to buffer/download first
- ⚠️ **ISP restrictions** - Some ISPs block P2P traffic

## 🔧 Configuration Generator

This repository includes a powerful **configuration generator script** that allows you to create custom localized versions by combining the base configuration with locale-specific settings.

### 🚀 Quick Start

Generate a French configuration (two equivalent ways):

- From the repository root:
```bash
./generate-config/generate-config.sh french
```

- From inside the `generate-config/` directory:
```bash
cd generate-config && ./generate-config.sh french
```

Note: the script now always writes the generated file to the repository root as `aiostreams-config-<locale>.json` (e.g. `aiostreams-config-french.json`).

### 📁 How It Works

The generator combines:
- **Base configuration**: `aiostreams-config.json` (repo root)
- **Locale-specific settings**: `generate-config/{locale}.json` (inside `generate-config/`)
- **Output**: `aiostreams-config-{locale}.json` (created in the repository root)

### 🌍 Available Locales

- **French**: `./generate-config.sh french`
  - Includes TvVoo France addon
  - French language priority
  - France-specific catalogs

### 🛠️ Creating New Locales

1. **Create a locale file** in `generate-config/` (e.g., `spanish.json`):

```json
{
  "languagePreferences": {
    "languages": ["es", "en", "multi"],
    "preferredLanguages": ["Spanish", "English", "Unknown"]
  },
  "additionalPresets": [
    {
      "type": "custom",
      "instanceId": "es1",
      "enabled": true,
      "options": {
        "name": "Spanish Addon",
        "manifestUrl": "stremio://example.com/manifest.json",
        "formatPassthrough": true,
        "resultPassthrough": true
      }
    }
  ],
  "additionalCatalogs": [
    {
      "id": "es_catalog",
      "name": "Spanish Catalog",
      "type": "tv",
      "enabled": true,
      "shuffle": false,
      "rpdb": false,
      "hideable": true,
      "searchable": false,
      "addonName": "SpanishAddon"
    }
  ],
  "countrySpecific": {
    "region": "Spain",
    "prioritizeLocalContent": true
  }
}
```

2. **Run the generator**:
```bash
./generate-config.sh spanish
```

### 📋 Configuration Structure

#### Language Preferences
- `languages`: Language code priority (e.g., `["fr", "en", "multi"]`)
- `preferredLanguages`: Full language names (e.g., `["French", "English"]`)

#### Additional Presets
Array of locale-specific addons/presets to add to the base configuration.

#### Additional Catalogs
Array of locale-specific catalogs to include.

#### Country Specific
Region-specific settings and preferences.

### 🔧 Dependencies

The script requires:
- **`jq`** - For JSON processing
- **`bash`** - For script execution

Install jq:
```bash
# Ubuntu/Debian
sudo apt-get install jq

# macOS
brew install jq
```

### ✨ Features

- ✅ **JSON validation** - Ensures generated configs are valid
- ✅ **Error handling** - Clear error messages and validation
- ✅ **Colored output** - Easy-to-read terminal feedback
- ✅ **Dependency checking** - Automatic verification of requirements
- ✅ **Flexible structure** - Easy to extend for new locales

### 🔑 Complete Setup (Recommended)

For the **ultimate streaming experience**, consider also configuring these **premium addons** from the enhanced configurations:

<img width="2880" height="1800" alt="image" src="https://github.com/user-attachments/assets/b6b20513-d8ba-4d08-8da5-a87f9dbcdd48" />
<img width="2880" height="1800" alt="image" src="https://github.com/user-attachments/assets/db217b34-653c-4bf9-b6ab-05cf42114d7e" />

**Personal Tracking & Lists:**
- **[AIOLists](https://github.com/SebastianMorel/AIOLists)** - Connect your Trakt account for personalized recommendations, watchlists, and trending content
- **[SyncriBullet](https://github.com/aliyss/syncribullet)** - Sync across multiple platforms (Simkl, AniList, Kitsu, TVTime)
- **[MAL-Stremio Addon](https://github.com/SageTendo/mal-stremio-addon)** - MyAnimeList integration for anime enthusiasts

**Enhanced Metadata:**
- **[AIOMetadata](https://github.com/cedya77/aiometadata)** - Rich movie/TV information with TMDB integration (I recommend [this setup](https://www.reddit.com/r/StremioAddons/comments/1mzqfgn/best_aio_metadata_setup_stable_clean_spoilerfree/))
- **[Animeo](https://github.com/Jenrykster/animeo)** - Advanced anime discovery and tracking

**IPTV Integration:**
- **[M3U/EPG Addon](https://github.com/Inside4ndroid/M3U-XCAPI-EPG-IPTV-Stremio)** - Add your IPTV channels and live content

**Why these aren't included:**
These addons require **individual API keys, personal accounts, or private configurations** that each user must set up themselves. They cannot be shared in a public configuration due to security and terms of service restrictions.

## Recommended Usage

### Windows (Recommended)
For **Windows users**, the recommended setup is:
- **[Stremio Community v5](https://github.com/Zaarrg/stremio-community-v5)** - Enhanced Stremio client with additional features

### Linux (Recommended)
For **Linux users**, the recommended setup is:
- **[Stremio Web](https://web.stremio.com)** - Official web version
- **[Open Stremio Links on MPV](https://github.com/ang3lo-azevedo/open-stremio-links-on-mpv)** - Userscript that opens stream links directly in MPV
- **[MPV Configuration](https://github.com/ang3lo-azevedo/mpv)** - Optimized MPV settings for best streaming experience

### Alternative Setup (Windows/Linux)
**Windows users** can also use the **Linux setup** (Stremio Web + MPV userscript). The MPV configuration scripts can also be used with Stremio Community for enhanced playback.

## 📝 Notes

- Configuration **optimized for Real-Debrid** but **works without it**
- **With Real-Debrid**: Instant premium streaming with maximum quality
- **Without Real-Debrid**: Free P2P streaming with some limitations
- **Timeouts** adjusted for performance (5s-15s depending on addon)
- **Automatic filters** remove low-quality content
- **Priority** for Portuguese content through `forceToTop`
- **Subtitles** focused on Portuguese and English
- **Alternative debrid services** can be enabled (AllDebrid, Premiumize, etc.)
