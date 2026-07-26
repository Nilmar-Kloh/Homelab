#!/usr/bin/env bash

set -euo pipefail

source ./lib.sh

require_root

step "Starting Homelab Bootstrap"

for module in modules/*.sh
do
    bash "$module"
done

success "Bootstrap completed."
