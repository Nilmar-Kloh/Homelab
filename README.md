# Homelab Bootstrap

This repository standardizes every Debian server in my homelab (except the Proxmox host).

The goal is simple:

> Install Debian → Configure networking → Clone this repository → Run one command → Obtain the standard homelab baseline.

The bootstrap configures the operating system for:

- Linux administration
- Docker
- Python development
- DevOps / GitOps tooling
- Platform engineering

---

# Repository Structure

```text
homelab/

bootstrap/
compose/
configs/
docs/
inventory/
scripts/
templates/
README.md
```

The only directory required during provisioning is:

```text
bootstrap/
```

---

# Bootstrap Modules

```text
01-system.sh
```

- Updates Debian
- Upgrades packages
- Cleans package cache

```text
02-packages.sh
```

Installs the baseline software stack.

```text
03-directories.sh
```

Creates the standard directory structure.

```text
04-python.sh
```

Configures the Python development environment.

```text
05-docker.sh
```

Installs and configures Docker.

```text
06-security.sh
```

Configures SSH, UFW and Fail2Ban.

```text
07-report.sh
```

Generates the machine inventory.

---

# Provisioning Workflow

```text
Install Debian
        │
        ▼
Configure Network
        │
        ▼
Install Git
        │
        ▼
Configure GitHub SSH
        │
        ▼
Clone Repository
        │
        ▼
Run Bootstrap
```

---

# Manual Installation

The following steps are intentionally manual.

## 1. Install Debian

Recommended installation:

- Debian Stable
- Minimal installation
- OpenSSH Server
- No Desktop Environment

---

## 2. Configure Networking

Set:

- Hostname
- Static IP
- Gateway
- DNS

Example

```text
Hostname : homelab02

IP        : 192.168.0.39

Gateway   : 192.168.0.1

DNS       : 192.168.0.1
            1.1.1.1
```

Verify:

```bash
ping 1.1.1.1

ping github.com
```

Verify routing:

```bash
ip route
```

Expected:

```text
default via 192.168.0.1 dev eno1
```

---

## 3. Install Git

```bash
su -

apt update

apt install git
```

---

## 4. Configure Git

```bash
git config --global user.name "Your Name"

git config --global user.email "you@email.com"
```

---

## 5. Generate GitHub SSH Key

```bash
ssh-keygen -t ed25519
```

Display the key:

```bash
cat ~/.ssh/id_ed25519.pub
```

---

## 6. Add the Key to GitHub

GitHub

```text
Settings

SSH and GPG Keys

New SSH Key
```

Test:

```bash
ssh -T git@github.com
```

---

## 7. Clone Repository

```bash
mkdir -p ~/Git

cd ~/Git

git clone git@github.com:Nilmar-Kloh/homelab.git
```

---

# Bootstrap

Run:

```bash
cd ~/Git/homelab/bootstrap

sudo ./bootstrap.sh
```

---

# After Bootstrap

Docker group membership requires a new login.

Log out.

Log back in.

Verify:

```bash
docker ps
```

---

# Generated Inventory

The bootstrap generates:

```text
inventory/

homelab01.md

homelab02.md

homelab03.md
```

The report contains:

- Operating System
- CPU
- RAM
- Storage
- Network
- Installed software
- Installed versions
- Services
- Validation checks

Commit the report after verifying the machine.

---

# Known Issues

## DNS

If DNS resolution fails:

```bash
ping github.com
```

returns

```text
Temporary failure in name resolution
```

Verify:

```bash
cat /etc/resolv.conf
```

Expected:

```text
nameserver 192.168.0.1
nameserver 1.1.1.1
```

If necessary:

```bash
sudo nano /etc/resolv.conf
```

Insert:

```text
nameserver 192.168.0.1
nameserver 1.1.1.1
```

Reboot and verify the configuration persists.

---

## Docker

If:

```bash
docker ps
```

returns

```text
permission denied while trying to connect to the Docker daemon
```

Log out and back in.

Verify group membership:

```bash
groups
```

Expected:

```text
docker
```

---

## Network

Verify:

```bash
ip route
```

Expected:

```text
default via 192.168.0.1
```

Verify connectivity:

```bash
ping 1.1.1.1

ping github.com
```

---

# Updating the Baseline

When changing the homelab standard:

1. Modify the appropriate bootstrap module.
2. Commit the changes.
3. Push to GitHub.
4. Pull the repository on the remaining machines.
5. Run:

```bash
cd ~/Git/homelab/bootstrap

sudo ./bootstrap.sh
```

The bootstrap can safely be executed multiple times to keep machines aligned with the current baseline.

---

# Current Scope

This bootstrap standardizes the operating system only.

It does **not**:

- Install Debian
- Partition disks
- Configure networking
- Generate GitHub SSH keys
- Deploy Docker containers
- Provision Kubernetes

Those tasks remain intentionally manual.