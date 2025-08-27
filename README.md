# AIOStreams Configuration

![AIOStreams Configuration](https://github.com/user-attachments/assets/6f23909e-982f-4084-b3c6-173fbae12756)

## 📋 Overview

This is a custom **[AIOStreams](https://github.com/reddravenn/AIOStreams)** configuration for **[Stremio](https://github.com/Stremio/stremio-shell)**, optimized for Portuguese and English content with a focus on high quality. The configuration uses Real-Debrid as the primary debrid service and includes a carefully selected collection of addons for maximum compatibility and quality.

### 🔗 Related Projects
- **[AIOStreams](https://github.com/reddravenn/AIOStreams)** - Advanced Stremio addon aggregator
- **[Stremio](https://github.com/Stremio/stremio-shell)** - Modern media center and streaming platform

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
  - Remove Trash: Yes
  - Services: Real-Debrid
- **Description**: Stream aggregator with intelligent filtering

#### **[MediaFusion](https://mediafusion.elfhosted.com/)**
- **Status**: ✅ Enabled
- **Resources**: Stream, Catalog, Meta  
- **Timeout**: 5000ms (optimized for speed)
- **Description**: Streams with enriched metadata

#### **StremThru Torz**
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

#### **TugaKids** 
- **Status**: ✅ Enabled
- **Configuration**: `forceToTop: true`
- **Description**: Animation and children's content in PT-PT

#### **[Reflux](https://github.com/Nightfruit/reflux)**
- **Status**: ✅ Enabled
- **Description**: Brazilian catalog with movies and series

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

#### **SubSource** ❌ 
- **Status**: Disabled

#### **AIOSubtitle** ❌
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

## 🎯 Quality Patterns (Regex)

The configuration includes sophisticated regex patterns to classify releases:

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

### Option 1: With Real-Debrid (Recommended)
1. **Import** the `aiostreams-config.json` file into AIOStreams
2. **Configure** your **[Real-Debrid](https://real-debrid.com/)** credentials in Services
3. **Install** the resulting addon in Stremio
4. **Enjoy** optimized quality content with instant streaming!

### Option 2: Without Real-Debrid (Free Alternative)
1. **Import** the `aiostreams-config.json` file into AIOStreams
2. **Keep Real-Debrid disabled** (or disable it in Services)
3. **Install** the resulting addon in Stremio
4. **Stream content** using P2P torrents and direct links

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

## 📝 Notes

- Configuration **optimized for Real-Debrid** but **works without it**
- **With Real-Debrid**: Instant premium streaming with maximum quality
- **Without Real-Debrid**: Free P2P streaming with some limitations
- **Timeouts** adjusted for performance (5s-15s depending on addon)
- **Automatic filters** remove low-quality content
- **Priority** for Portuguese content through `forceToTop`
- **Subtitles** focused on Portuguese and English
- **Alternative debrid services** can be enabled (AllDebrid, Premiumize, etc.)
