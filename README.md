# rcrawler

High-performance web crawler built in Rust.

## Features

- **Fast**: Async crawling with Tokio runtime (60+ pages/sec)
- **Configurable**: Worker pool, depth control, rate limiting
- **Smart**: Automatic sitemap discovery and robots.txt compliance
- **Rich output**: JSON data + interactive HTML report with graph visualization
- **Safe**: Built-in rate limiting and server-friendly defaults
- **Monitoring**: Real-time progress updates and structured logging

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

- `results.json` - Structured crawl data with stats and page details
- `index.html` - Interactive visual report with graph visualization and dark/light theme

## Performance

- Throughput: 60+ pages/sec
- Memory: ~50MB
- Binary size: 5.4 MB
- Startup time: <50ms

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
