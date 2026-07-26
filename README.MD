# Homelab Bootstrap

This repository standardizes every Debian machine in my homelab with the exception of my proxmox server.

The bootstrap configures the operating system so every machine shares the same baseline for development, Docker and infrastructure. Most of the work I do focus on containers/VMs and platform engineering as well as DevOps / GitOps disciplines.

---

# Current Architecture

```
Fresh Debian
      │
      ▼
Manual configuration
      │
      ▼
Clone repository
      │
      ▼
sudo ./bootstrap.sh
      │
      ▼
Standardized machine
```

---

# Manual Installation

These steps are intentionally **not automated**.

## 1. Install Debian

Install Debian Stable using the standard installer.

Recommended:

- Minimal installation
- SSH Server
- No desktop environment

---

## 2. Configure Networking inside of local Network; this is only for static IP address configurations

Configure:

- Hostname
- Static IP
- Gateway
- DNS

Example

```
Hostname: homelab02

IP: 192.168.0.39

Gateway: 192.168.0.1

DNS: 192.168.0.1
```

Verify

```bash
ping github.com
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

git config --global user.email "your@email.com"
```

---

## 5. Generate SSH Key

```bash
ssh-keygen -t ed25519
```

Display the public key

```bash
cat ~/.ssh/id_ed25519.pub
```

---

## 6. Add SSH Key to GitHub

GitHub

```
Settings

SSH and GPG Keys

New SSH Key
```

Paste the public key.

Test

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

Go to

```bash
cd ~/Git/homelab/bootstrap
```

Run

```bash
sudo ./bootstrap.sh
```

The bootstrap performs:

- Update Debian
- Install baseline packages
- Create directory structure
- Configure Python tooling
- Configure Docker
- Configure Security
- Generate inventory report

---

# Directory Structure

```
bootstrap/

bootstrap.sh

lib.sh

modules/

01-system.sh

02-packages.sh

03-directories.sh

04-python.sh

05-docker.sh

06-security.sh

07-report.sh
```

---

# Adding a New Machine

Repeat the manual steps:

- Install Debian
- Configure networking
- Install Git
- Configure Git
- Configure GitHub SSH
- Clone repository

Then execute

```bash
sudo ./bootstrap.sh
```

No changes to the bootstrap are required.

---

# Generated Report

At the end of the bootstrap an inventory is generated.

```
inventory/

homelab01.md

homelab02.md

homelab03.md
```

Each report contains

- Operating System
- CPU
- Memory
- Storage
- Network
- Installed software
- Service status
- Validation results

Commit the updated inventory after verifying the machine.

---

# Updating the Components

When adding software or changing the standard:

1. Modify the appropriate module.
2. Commit the change.
3. Pull the repository on the remaining machines.
4. Run the bootstrap again.
