#!/usr/bin/env bash

source ./lib.sh

step "Generating machine report"

REPORT="../inventory/$(hostname).md"

cat > "$REPORT" <<EOF
# $(hostname)

## Bootstrap

- Date: $(date)
- Status: SUCCESS

---

## Operating System

- OS: $(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
- Kernel: $(uname -r)
- Architecture: $(uname -m)

---

## Hardware

### CPU

$(lscpu | grep "Model name")

Cores: $(nproc)

### Memory

$(free -h | awk '/Mem:/ {print $2 " total / " $7 " available"}')

---

## Storage

\`\`\`
$(lsblk -f)
\`\`\`

---

## Network

Hostname: $(hostname)

IPv4: $(hostname -I | awk '{print $1}')

Gateway: $(ip route | awk '/default/ {print $3}')

---

## Software

| Software | Version |
|----------|---------|
| Git | $(git --version | cut -d' ' -f3) |
| Python | $(python3 --version | cut -d' ' -f2) |
| uv | $(uv --version | cut -d' ' -f2) |
| Docker | $(docker --version | cut -d' ' -f3 | tr -d ',') |
| Compose | $(docker compose version | awk '{print $4}') |

---

## Services

| Service | Status |
|----------|--------|
| SSH | $(systemctl is-active ssh) |
| Docker | $(systemctl is-active docker) |
| Fail2Ban | $(systemctl is-active fail2ban) |
| UFW | $(systemctl is-active ufw) |

---

## Validation

| Check | Result |
|-------|--------|
| Internet | $(ping -c1 1.1.1.1 >/dev/null 2>&1 && echo PASS || echo FAIL) |
| DNS | $(getent hosts github.com >/dev/null 2>&1 && echo PASS || echo FAIL) |
| Docker | $(docker info >/dev/null 2>&1 && echo PASS || echo FAIL) |
| Python | $(python3 --version >/dev/null 2>&1 && echo PASS || echo FAIL) |
| uv | $(uv --version >/dev/null 2>&1 && echo PASS || echo FAIL) |

EOF

success "Report generated: $REPORT"
