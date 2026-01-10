#!/bin/bash
# Update rcrawler binary in Claude skill after development changes
set -euo pipefail

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}[1/4]${NC} Building release binary..."
cargo build --release

echo -e "${BLUE}[2/4]${NC} Checking binary size..."
ls -lh target/release/rcrawler | awk '{print $5, $9}'

echo -e "${BLUE}[3/4]${NC} Copying to skill directory..."
cp target/release/rcrawler ~/.claude/skills/web-crawler/bin/

echo -e "${BLUE}[4/4]${NC} Verifying installation..."
~/.claude/skills/web-crawler/bin/rcrawler --help | head -3

echo -e "${GREEN}✓ Skill binary updated successfully!${NC}"
echo ""
echo "Binary location: ~/.claude/skills/web-crawler/bin/rcrawler"
echo "Test with: ~/.claude/skills/web-crawler/bin/rcrawler https://example.com"
