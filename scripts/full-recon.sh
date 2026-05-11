#!/bin/bash
# full-recon.sh — Full recon pipeline
# Usage: ./full-recon.sh <TARGET_IP>
# ⚠️ Authorized targets only

TARGET=${1:?"Usage: $0 <TARGET_IP>"}
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
OUTPUT_DIR="./output-templates/recon_$TIMESTAMP"

mkdir -p "$OUTPUT_DIR"

echo "============================================"
echo "  FULL RECON PIPELINE"
echo "  Target: [REDACTED FOR REPO]"
echo "  Started: $TIMESTAMP"
echo "============================================"
echo ""

# Run all phases
bash "$(dirname "$0")/port-scan.sh" "$TARGET" "$OUTPUT_DIR"
bash "$(dirname "$0")/http-enum.sh" "$TARGET" 80 "$OUTPUT_DIR"
bash "$(dirname "$0")/http-enum.sh" "$TARGET" 443 "$OUTPUT_DIR"

echo ""
echo "[+] Full recon complete. Results in $OUTPUT_DIR"
echo "[!] Run sanitize.sh before pushing: ./sanitize.sh $OUTPUT_DIR"
