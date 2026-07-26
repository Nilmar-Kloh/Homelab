#!/usr/bin/env bash

set -euo pipefail

step() {
    echo
    echo "=========================================="
    echo "$1"
    echo "=========================================="
}

success() {
    echo "[OK] $1"
}

warning() {
    echo "[WARNING] $1"
}

error() {
    echo "[ERROR] $1"
    exit 1
}

require_root() {
    [[ $EUID -eq 0 ]] || error "Run with sudo."
}
