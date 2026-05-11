#!/bin/bash
# http-enum.sh — HTTP/HTTPS service enumeration
# Usage: ./http-enum.sh <TARGET_IP> [port]
# ⚠️ Authorized targets only

TARGET=${1:?"Usage: $0 <TARGET_IP> [port]"}
PORT=${2:-80}
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
OUTPUT_DIR="./output-templates"

if [ ! -d "$OUTPUT_DIR" ]; then mkdir -p "$OUTPUT_DIR"; fi

echo "[*] HTTP enumeration against TARGET_IP:$PORT"

# Banner grab
echo "[*] Grabbing HTTP headers..."
curl -sI "http://$TARGET:$PORT" | tee "$OUTPUT_DIR/headers_$TIMESTAMP.txt"

# SSL check if port 443
if [ "$PORT" -eq 443 ]; then
  echo "[*] Checking SSL certificate..."
  echo | openssl s_client -connect "$TARGET:$PORT" 2>/dev/null \
    | openssl x509 -noout -dates -subject \
    | tee "$OUTPUT_DIR/ssl_$TIMESTAMP.txt"
fi

echo ""
echo "[+] HTTP enum complete. Output saved to $OUTPUT_DIR/"
echo "[!] Sanitize before committing — remove real IPs and hostnames"
