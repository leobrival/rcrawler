# Development Workflow

## Setup

This repository is the **development environment** for rcrawler. The production binary is deployed to `~/.claude/skills/web-crawler/bin/`.

### Directory Structure

```
~/Developer/scripts/rcrawler/  # Development (this repo)
├── src/                       # Source code
├── target/                    # Build artifacts (gitignored)
├── Cargo.toml                 # Dependencies
├── update-skill.sh            # Deployment script
└── DEVELOPMENT.md             # This file

~/.claude/skills/web-crawler/  # Production (deployed)
├── bin/rcrawler              # Binary deployed from here
├── scripts/                  # Code source (backup)
└── SKILL.md                  # Documentation
```

## Development Workflow

### 1. Make Changes

```bash
cd ~/Developer/scripts/rcrawler
# Edit files in src/
```

### 2. Test Locally

```bash
# Build and test
cargo build --release
./target/release/rcrawler https://example.com

# Run tests
cargo test

# Run with debug logs
RUST_LOG=debug ./target/release/rcrawler https://example.com --debug
```

### 3. Commit & Push

```bash
git add .
git commit -m "feat: your changes"
git push origin main
```

### 4. Update Production Binary

```bash
# Option A: Use the update script
./update-skill.sh

# Option B: Manual update
cargo build --release
cp target/release/rcrawler ~/.claude/skills/web-crawler/bin/
```

### 5. Update Source Backup (Optional)

If you want to keep the source code in the skill directory synchronized:

```bash
# Copy source files (without .git)
rsync -av --exclude='.git' --exclude='target' \
  ~/Developer/scripts/rcrawler/ \
  ~/.claude/skills/web-crawler/scripts/
```

## Quick Commands

```bash
# Build optimized binary
cargo build --release

# Build with debug info
cargo build

# Run tests
cargo test

# Check code without building
cargo check

# Format code
cargo fmt

# Lint code
cargo clippy

# Clean build artifacts
cargo clean

# Update dependencies
cargo update

# Deploy to skill
./update-skill.sh
```

## Testing Profiles

```bash
# Fast profile (50 workers)
./target/release/rcrawler https://example.com -p fast

# Deep profile (comprehensive)
./target/release/rcrawler https://example.com -p deep

# Gentle profile (server-friendly)
./target/release/rcrawler https://example.com -p gentle

# Custom configuration
./target/release/rcrawler https://example.com -w 30 -d 5 -r 5

# With debug logging
./target/release/rcrawler https://example.com --debug
```

## Benchmarking

```bash
# Time a crawl
time ./target/release/rcrawler https://example.com

# With perf profiling (Linux)
perf record ./target/release/rcrawler https://example.com
perf report

# Memory profiling with valgrind
valgrind --tool=massif ./target/release/rcrawler https://example.com
```

## Troubleshooting

### Binary Not Found

```bash
# Check if binary exists
ls -lh target/release/rcrawler

# Rebuild if missing
cargo build --release
```

### Compilation Errors

```bash
# Clean and rebuild
cargo clean
cargo build --release
```

### Test Failures

```bash
# Run specific test
cargo test test_name

# Run with output
cargo test -- --nocapture

# Run with debug logs
RUST_LOG=debug cargo test
```

## Release Process

1. Update version in `Cargo.toml`
2. Update `CHANGELOG.md` (if exists)
3. Commit: `git commit -m "chore: bump version to X.Y.Z"`
4. Tag: `git tag -a vX.Y.Z -m "Release X.Y.Z"`
5. Push: `git push origin main --tags`
6. Deploy: `./update-skill.sh`

## Documentation

- **Project README**: `README.md`
- **Skill Documentation**: `~/.claude/skills/web-crawler/SKILL.md`
- **Architecture**: `CLAUDE.md`
- **Feature Comparison**: `FEATURE_COMPARISON.md`
- **Completion Report**: `COMPLETION_REPORT.md`

## GitHub Repository

- **URL**: https://github.com/leobrival/rcrawler
- **Remote**: `origin`
