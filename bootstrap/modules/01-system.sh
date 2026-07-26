#!/usr/bin/env bash

source ./lib.sh

step "Updating Debian"

apt update
apt full-upgrade -y
apt autoremove --purge -y
apt clean

success "System updated."
