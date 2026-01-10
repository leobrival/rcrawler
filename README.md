# rcrawler

High-performance web crawler written in pure Rust with production-grade features.

## Features

- ⚡ **Fast**: 60+ pages/sec with async Tokio runtime
- 🔧 **Configurable**: Worker pool, depth, rate limiting
- 🤖 **Smart**: Sitemap discovery, robots.txt support
- 📊 **Rich output**: JSON + interactive HTML report with graph visualization
- 🎨 **Beautiful**: Dark/light theme auto-detection
- 📋 **Profiles**: fast/deep/gentle presets
- 🔒 **Safe**: Rate limiting (2 req/s default), respects robots.txt
- 📈 **Monitoring**: Real-time progress updates every 5 seconds
- 📝 **Logging**: Structured logging with tracing

## Claude Code Integration

This crawler is integrated with [Claude Code](https://claude.ai/code) as a skill.

See the [Claude Code skill](https://github.com/leobrival/.claude/tree/main/skills/web-crawler) for:
- Natural language crawl requests
- Real-time progress monitoring
- Automatic result opening
- Command reference

## Installation

```bash
cargo build --release
```

## Usage

```bash
# Basic crawl
./target/release/rcrawler https://example.com

# With options
./target/release/rcrawler https://example.com -w 20 -d 3 -r 5

# Using a profile
./target/release/rcrawler https://example.com -p fast

# Custom output directory
./target/release/rcrawler https://example.com -o ./my-results
```

## Options

- `-d, --depth <NUM>`: Maximum crawl depth (default: 2)
- `-w, --workers <NUM>`: Number of concurrent workers (default: 20)
- `-r, --rate <NUM>`: Rate limit in requests/sec (default: 2.0)
- `-p, --profile <NAME>`: Use predefined profile (fast, deep, gentle)
- `-o, --output <DIR>`: Output directory (default: ./output)
- `--domain <DOMAIN>`: Restrict crawling to this domain
- `-s, --sitemap`: Enable/disable sitemap.xml discovery (default: true)
- `--debug`: Enable debug logging
- `--resume`: Resume from checkpoint if available

## Profiles

- **fast**: 50 workers, depth 3, rate 10/s - Quick site mapping
- **deep**: 20 workers, depth 10, rate 3/s - Comprehensive crawl
- **gentle**: 5 workers, depth 5, rate 1/s - Server-friendly

## Output

The crawler generates two files in the output directory:

### 1. JSON Results (`results.json`)

Machine-readable crawl data in JSON format:

```json
{
  "stats": {
    "pagesFound": 100,
    "pagesCrawled": 95,
    "externalLinks": 50,
    "excludedLinks": 25,
    "errors": 5,
    "startTime": "2026-01-09T10:30:00Z",
    "endTime": "2026-01-09T10:35:00Z",
    "duration": 300000
  },
  "results": [
    {
      "url": "https://example.com",
      "title": "Example Domain",
      "statusCode": 200,
      "depth": 0,
      "links": ["https://example.com/page1"],
      "crawledAt": "2026-01-09T10:30:05Z",
      "contentType": "text/html"
    }
  ]
}
```

### 2. HTML Report (`index.html`)

Interactive visual report with:

- **Dashboard view**:
  - Stats cards (pages crawled, links found, errors, duration)
  - Pages grouped by depth
  - Collapsible link sections
  - Status badges (200 = success, other = error)

- **Graph view**:
  - Force-directed graph visualization
  - Interactive nodes (hover for details, click to open)
  - Visual link relationships
  - Auto-layout with zoom/pan

- **Features**:
  - Dark/light theme (auto-detection via `prefers-color-scheme`)
  - Responsive design (mobile-friendly)
  - Fast rendering with force-graph library
  - No external dependencies (CDN-hosted fonts + force-graph)

Open the report by navigating to `./output/index.html` in your browser.

## Performance

### Benchmarks

Real-world performance (depth 2, 20 workers):

| Site | Pages | Time | Throughput |
|------|-------|------|------------|
| adonisjs.com | 450 | 6.5s | **69 pages/s** ⚡ |
| rust-lang.org/book | 1119 | 35s | **32 pages/s** |
| github.com/anthropics | 162 | 13s | 12 pages/s |
| docs.rs | 28 | 3s | 9 pages/s |

### Metrics

- **Throughput**: 60+ pages/sec
- **Memory**: ~50MB
- **Binary size**: 5.4 MB
- **Startup time**: <50ms

## Features Status

### Implemented ✅

- HTML report generation with graph visualization
- Sitemap.xml discovery (regular + index)
- robots.txt support with per-domain caching
- Checkpoint/resume capability
- Exclude patterns for static files
- Raycast integration
- Rate limiting with token bucket algorithm
- Structured logging with tracing
- Real-time progress monitoring

### Future Enhancements

- JavaScript rendering with headless browser
- Distributed crawling with Redis queue
- Dynamic resource limits based on CPU/RAM
- LLM-ready markdown output

## Development

```bash
# Run tests
cargo test

# Run linter
cargo clippy

# Format code
cargo fmt

# Build optimized binary
cargo build --release
```

## License

MIT
