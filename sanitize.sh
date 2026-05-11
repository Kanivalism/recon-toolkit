#!/bin/bash
# =============================================================================
# sanitize.sh — Run before EVERY git push
# Scans for sensitive data: IPs, credentials, hostnames
# macOS compatible
# =============================================================================

TARGET_DIR=${1:-.}
FOUND=0

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo ""
echo "=================================================="
echo "  🔍 SANITIZE SCAN — $(date '+%Y-%m-%d %H:%M')"
echo "  Directory: $TARGET_DIR"
echo "=================================================="

# ── 1. IP addresses ──────────────────────────────────────────────────────────
echo -e "\n${YELLOW}[1/4] Scanning for IP addresses...${NC}"
HITS=$(grep -rEn '([0-9]{1,3}\.){3}[0-9]{1,3}' "$TARGET_DIR" \
  --include="*.txt" --include="*.md" --include="*.sh" \
  --include="*.py" --include="*.conf" --include="*.yaml" \
  --include="*.json" --exclude-dir=".git" 2>/dev/null \
  | grep -v '192\.0\.2\.' \
  | grep -v '198\.51\.100\.' \
  | grep -v '203\.0\.113\.' \
  | grep -v '127\.0\.0\.1' \
  | grep -v '0\.0\.0\.0')
if [ -n "$HITS" ]; then
  echo -e "${RED}FOUND — review these:${NC}"
  echo "$HITS"
  FOUND=1
else
  echo -e "${GREEN}Clean${NC}"
fi

# ── 2. Credentials ───────────────────────────────────────────────────────────
echo -e "\n${YELLOW}[2/4] Scanning for credentials...${NC}"
HITS=$(grep -rEin '(password|passwd|secret|token|api_key|apikey|auth)\s*[=:]' "$TARGET_DIR" \
  --include="*.txt" --include="*.md" --include="*.sh" \
  --include="*.py" --include="*.conf" --include="*.yaml" \
  --include="*.json" --exclude-dir=".git" 2>/dev/null)
if [ -n "$HITS" ]; then
  echo -e "${RED}FOUND — review these:${NC}"
  echo "$HITS"
  FOUND=1
else
  echo -e "${GREEN}Clean${NC}"
fi

# ── 3. Hostnames ─────────────────────────────────────────────────────────────
echo -e "\n${YELLOW}[3/4] Scanning for real hostnames...${NC}"
HITS=$(grep -rEin '(synology|javive|\.synology\.me|\.local)' "$TARGET_DIR" \
  --include="*.txt" --include="*.md" --include="*.sh" \
  --include="*.py" --include="*.conf" --exclude-dir=".git" 2>/dev/null)
if [ -n "$HITS" ]; then
  echo -e "${RED}FOUND — review these:${NC}"
  echo "$HITS"
  FOUND=1
else
  echo -e "${GREEN}Clean${NC}"
fi

# ── 4. SSH keys ───────────────────────────────────────────────────────────────
echo -e "\n${YELLOW}[4/4] Scanning for SSH key material...${NC}"
HITS=$(grep -rEl '(BEGIN RSA PRIVATE KEY|BEGIN OPENSSH PRIVATE KEY|BEGIN EC PRIVATE KEY)' \
  "$TARGET_DIR" --exclude-dir=".git" 2>/dev/null)
if [ -n "$HITS" ]; then
  echo -e "${RED}FOUND private key material in:${NC}"
  echo "$HITS"
  FOUND=1
else
  echo -e "${GREEN}Clean${NC}"
fi

# ── Result ────────────────────────────────────────────────────────────────────
echo ""
echo "=================================================="
if [ $FOUND -eq 1 ]; then
  echo -e "${RED}  ⛔ Issues found — DO NOT push until resolved${NC}"
  echo "  Replace real values with placeholders:"
  echo "  IP → <TARGET_IP> or 192.0.2.x"
  echo "  Hostname → <TARGET_HOST>"
  echo "  Password → <REDACTED>"
  exit 1
else
  echo -e "${GREEN}  ✅ All clean — safe to push${NC}"
  exit 0
fi
echo "=================================================="
echo ""
