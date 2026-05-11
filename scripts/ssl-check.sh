#!/bin/bash
# ssl-check.sh — SSL/TLS certificate and cipher analysis
# Usage: ./ssl-check.sh <TARGET_HOST> [port]
# ⚠️ Authorized targets only

TARGET=${1:?"Usage: $0 <TARGET_HOST> [port]"}
PORT=${2:-443}

echo "[*] SSL/TLS analysis for TARGET_HOST:$PORT"
echo ""

echo "[*] Certificate info:"
echo | openssl s_client -connect "$TARGET:$PORT" 2>/dev/null | openssl x509 -noout -text \
  | grep -E "(Subject:|Issuer:|Not Before:|Not After:|DNS:)"

echo ""
echo "[*] Supported protocols:"
for proto in ssl2 ssl3 tls1 tls1_1 tls1_2 tls1_3; do
  result=$(echo | openssl s_client -"$proto" -connect "$TARGET:$PORT" 2>&1)
  if echo "$result" | grep -q "Cipher is"; then
    echo "  [+] $proto — SUPPORTED"
  else
    echo "  [-] $proto — not supported"
  fi
done
