#!/usr/bin/env bash

source ./lib.sh

step "Configuring security"

systemctl enable ssh
systemctl enable fail2ban
systemctl enable ufw

ufw default deny incoming
ufw default allow outgoing
ufw allow OpenSSH

success "Security configured."
