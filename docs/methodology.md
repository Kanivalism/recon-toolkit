# Recon Methodology

## Phase 1 — Passive Reconnaissance
- WHOIS lookup
- DNS enumeration (A, MX, NS, TXT records)
- Certificate transparency logs (crt.sh)
- OSINT (Shodan, Censys)

## Phase 2 — Active Reconnaissance
- Full port scan (all 65535 ports)
- Service and version detection on open ports
- OS fingerprinting

## Phase 3 — Service Enumeration
- HTTP/HTTPS header analysis
- SSL/TLS configuration review
- Directory enumeration (if in scope)
- SMB/FTP enumeration if applicable

## Phase 4 — Documentation
- Sanitize all output (remove real IPs/hostnames)
- Save to output-templates/
- Write up findings

## Safe IP Placeholders
Use RFC 5737 documentation IPs in all public docs:
- 192.0.2.x (TEST-NET-1)
- 198.51.100.x (TEST-NET-2)
- 203.0.113.x (TEST-NET-3)
