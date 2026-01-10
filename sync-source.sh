#!/bin/bash
# Sync source code to skill directory (optional backup)
set -euo pipefail

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

SKILL_DIR="$HOME/.claude/skills/web-crawler/scripts"

echo -e "${BLUE}[INFO]${NC} Syncing source code to skill directory..."
echo ""

# Create scripts directory if it doesn't exist
mkdir -p "$SKILL_DIR"

# Sync files (excluding .git and build artifacts)
rsync -av \
  --exclude='.git' \
  --exclude='target' \
  --exclude='.DS_Store' \
  --exclude='output' \
  --exclude='*.tmp' \
  --exclude='update-skill.sh' \
  --exclude='sync-source.sh' \
  --exclude='DEVELOPMENT.md' \
  ~/Developer/scripts/rcrawler/ \
  "$SKILL_DIR/"

echo ""
echo -e "${GREEN}✓ Source code synced successfully!${NC}"
echo ""
echo "Files synced to: $SKILL_DIR"
echo ""
echo -e "${YELLOW}Note:${NC} This is optional. The skill only needs the binary (bin/rcrawler)."
echo "Source code in the skill is for reference and rebuilding if needed."
