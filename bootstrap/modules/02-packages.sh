#!/usr/bin/env bash

source ./lib.sh

step "Installing baseline packages"

apt install -y \
    git git-lfs \
    curl wget \
    vim nano tree \
    tmux \
    htop btop \
    jq yq \
    zip unzip p7zip-full \
    ripgrep fd-find bat \
    dnsutils net-tools \
    lsof ncdu iftop iotop \
    ufw fail2ban \
    openssh-server \
    python3 python3-pip python3-venv python3-dev pipx \
    build-essential cmake make gcc g++ \
    sqlite3 \
    ffmpeg \
    smartmontools nvme-cli

success "Baseline packages installed."
