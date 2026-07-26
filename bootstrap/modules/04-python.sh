#!/usr/bin/env bash

source ./lib.sh

step "Configuring Python"

# Install uv if missing
if ! command -v uv >/dev/null 2>&1; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# Ensure uv is available
export PATH="$HOME/.local/bin:$PATH"

# Install Ruff globally through uv
uv tool install ruff

success "Python toolchain configured."
