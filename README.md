# 🔍 recon-toolkit

A personal collection of reconnaissance scripts for authorized penetration testing and security research.

> ⚠️ **Legal Disclaimer:** This toolkit is intended for authorized security testing and educational purposes only. Use only on systems you own or have explicit written permission to test. The author is not responsible for misuse or damage.

## 📁 Structure

```
recon-toolkit/
├── scripts/          # Recon scripts (bash, python)
├── output-templates/ # Sanitized example outputs
├── wordlists/        # Custom wordlists (no sensitive data)
└── docs/             # Methodology and usage notes
```

## 🛠️ Scripts

| Script | Description | Usage |
|--------|-------------|-------|
| `full-recon.sh` | Full recon pipeline against a target | `./scripts/full-recon.sh <TARGET_IP>` |
| `port-scan.sh` | nmap wrapper with common flags | `./scripts/port-scan.sh <TARGET_IP>` |
| `http-enum.sh` | HTTP/HTTPS service enumeration | `./scripts/http-enum.sh <TARGET_IP>` |
| `ssl-check.sh` | SSL certificate and cipher analysis | `./scripts/ssl-check.sh <TARGET_HOST>` |

## ⚙️ Requirements

```bash
# Install via Homebrew (macOS)
brew install nmap curl wget python3

# Python dependencies
pip3 install requests
```

## 🚀 Quick Start

```bash
git clone https://github.com/Kanivalism/recon-toolkit
cd recon-toolkit
chmod +x scripts/*.sh

# Run full recon against a target you own
./scripts/full-recon.sh <TARGET_IP>
```

## 📋 Methodology

1. **Passive recon** — OSINT, DNS, WHOIS
2. **Active recon** — Port scanning, service detection
3. **HTTP enumeration** — Headers, SSL, directories
4. **Documentation** — Sanitized output saved to `/output-templates`

## 📚 References

- [Nmap Documentation](https://nmap.org/docs.html)
- [HTB Academy — Network Enumeration with Nmap](https://academy.hackthebox.com)
- [PTES Technical Guidelines](http://www.pentest-standard.org)

## 📄 License

MIT — see [LICENSE](LICENSE)
