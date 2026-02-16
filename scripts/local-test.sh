#!/usr/bin/env bash
# shellcheck shell=bash
# ==============================================================================
# Local test script for the Cloudflare Tunnel addon.
# Run inside the devcontainer to rebuild, start, and tail addon logs.
# The image: key in config.yaml is commented out during testing and
# automatically restored on exit (Ctrl+C).
# ==============================================================================
set -euo pipefail

ADDON_SLUG="local_cloudflared"
CONFIG_FILE="cloudflared/config.yaml"
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONFIG_PATH="${REPO_ROOT}/${CONFIG_FILE}"

# ---------------------------------------------------------------------------
# Guard: must be running inside the devcontainer
# ---------------------------------------------------------------------------
if ! command -v ha &>/dev/null; then
    echo "Error: 'ha' CLI not found. This script must run inside the HA devcontainer."
    exit 1
fi

# ---------------------------------------------------------------------------
# Toggle helpers
# ---------------------------------------------------------------------------
comment_image() {
    if grep -q '^image:' "$CONFIG_PATH"; then
        sed -i 's/^image:/# image:/' "$CONFIG_PATH"
        echo "Commented out image: in ${CONFIG_FILE}"
    else
        echo "image: already commented out in ${CONFIG_FILE}"
    fi
}

restore_image() {
    if grep -q '^# image:' "$CONFIG_PATH"; then
        sed -i 's/^# image:/image:/' "$CONFIG_PATH"
        echo "Restored image: in ${CONFIG_FILE}"
    fi
}

# ---------------------------------------------------------------------------
# Always restore config.yaml on exit
# ---------------------------------------------------------------------------
trap restore_image EXIT

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
comment_image

echo ""
echo "Rebuilding and starting ${ADDON_SLUG}..."
echo ""

ha addons rebuild "${ADDON_SLUG}"
ha addons start "${ADDON_SLUG}"

echo ""
echo "Tailing addon logs (Ctrl+C to stop and restore config.yaml)..."
echo ""

docker logs --follow "addon_${ADDON_SLUG}"
