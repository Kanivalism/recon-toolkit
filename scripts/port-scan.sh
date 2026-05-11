#!/bin/bash
# port-scan.sh — nmap wrapper for common pentest scenarios
# Usage: ./port-scan.sh <TARGET_IP> [output_dir]
# ⚠️ Authorized targets only

TARGET=${1:?"Usage: $0 <TARGET_IP>"}
OUTPUT_DIR=${2:-"./output-templates"}
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')

if [ ! -d "$OUTPUT_DIR" ]; then mkdir -p "$OUTPUT_DIR"; fi

echo "[*] Starting port scan against TARGET_IP"
echo "[*] Timestamp: $TIMESTAMP"
echo ""

# Phase 1: Fast all-ports scan
echo "[*] Phase 1: Fast all-ports scan..."
nmap -p- --min-rate 5000 -T4 "$TARGET" -oN "$OUTPUT_DIR/allports_$TIMESTAMP.txt"

# Phase 2: Targeted service/version detection on open ports
OPEN_PORTS=$(grep "^[0-9]" "$OUTPUT_DIR/allports_$TIMESTAMP.txt" | grep open | cut -d'/' -f1 | tr '\n' ',')
echo "[*] Open ports found: $OPEN_PORTS"

echo "[*] Phase 2: Service and version detection..."
nmap -sV -sC -p "$OPEN_PORTS" "$TARGET" -oN "$OUTPUT_DIR/services_$TIMESTAMP.txt"

echo ""
echo "[+] Scan complete. Results saved to $OUTPUT_DIR/"
echo "[!] Remember to sanitize output before committing to git"
