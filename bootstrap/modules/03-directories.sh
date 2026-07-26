#!/usr/bin/env bash

source ./lib.sh

step "Creating directory structure"

# User workspace
mkdir -p \
    "$HOME/Git" \
    "$HOME/Projects" \
    "$HOME/Notes" \
    "$HOME/Sandbox" \
    "$HOME/Scripts"

# Server structure
mkdir -p \
    /srv/stacks \
    /srv/data \
    /srv/config \
    /srv/backups

# Optional storage mount point
mkdir -p \
    /srv/storage

# Optional tools
mkdir -p \
    /opt/bin \
    /opt/tools \
    /opt/scripts

# Ownership
chown -R "$SUDO_USER:$SUDO_USER" \
    /srv/stacks \
    /srv/config

success "Directory structure created."
