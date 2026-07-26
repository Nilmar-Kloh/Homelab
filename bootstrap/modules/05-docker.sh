#!/usr/bin/env bash

source ./lib.sh

step "Installing Docker"

# Remove conflicting packages
apt remove -y docker.io docker-doc podman-docker containerd runc 2>/dev/null || true

# Prerequisites
apt install -y ca-certificates curl gnupg

# Docker repository
install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/debian/gpg \
| gpg --dearmor -o /etc/apt/keyrings/docker.gpg

chmod a+r /etc/apt/keyrings/docker.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/debian \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
> /etc/apt/sources.list.d/docker.list

apt update

# Install Docker
apt install -y \
docker-ce \
docker-ce-cli \
containerd.io \
docker-buildx-plugin \
docker-compose-plugin

# Enable Docker
systemctl enable docker
systemctl start docker

# Add current user
usermod -aG docker "$SUDO_USER"

success "Docker installed."