#!/usr/bin/env bash

# ──────────────────────────────────────────────
# Yazi Plugin Installer via "ya" package manager
# ──────────────────────────────────────────────

set -euo pipefail

# ── Plugin List (one per line) ────────────────
PLUGINS=(
    yazi-rs/plugins:piper
    yazi-rs/plugins:mime-ext
    yazi-rs/plugins:git
    yazi-rs/plugins:smart-enter
    yazi-rs/plugins:smart-filter
    yazi-rs/plugins:diff
    Lil-Dank/lazygit
    ndtoan96/ouch
    uhs-robert/recycle-bin
    stelcodes/bunny
    nsavvide/duck-radar
    simla33/ucp
    orhnk/system-clipboard
    boydaihungst/pref-by-location
    heretic-tripto/chezmoi
)

# ── Get currently installed plugins ───────────
INSTALLED=$(ya pkg list 2>/dev/null || true)

# ── Install ───────────────────────────────────
for plugin in "${PLUGINS[@]}"; do
    if echo "$INSTALLED" | grep -qF "$plugin"; then
        echo "  ⊘ ${plugin} (already installed)"
    else
        ya pkg add "${plugin}"
    fi
done
