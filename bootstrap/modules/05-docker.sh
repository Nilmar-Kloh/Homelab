#!/usr/bin/env bash

source ./lib.sh

step "Configuring Docker"

systemctl enable docker
systemctl start docker

usermod -aG docker "$SUDO_USER"

docker --version
docker compose version

success "Docker configured."
