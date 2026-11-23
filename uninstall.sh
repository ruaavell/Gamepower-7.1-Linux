#!/usr/bin/env bash
set -euo pipefail
UPSTREAM="https://raw.githubusercontent.com/gok8lp/headset-surround-linux/bd9c465fde8b42da19c6fbba5623e4467624eb5c/install.sh"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT
[[ "${EUID}" -ne 0 ]] || { echo "Root olarak çalıştırma."; exit 1; }
if command -v curl >/dev/null 2>&1; then
  curl -fL "$UPSTREAM" -o "$TMP_DIR/uninstall.sh"
else
  wget -O "$TMP_DIR/uninstall.sh" "$UPSTREAM"
fi
bash "$TMP_DIR/uninstall.sh" --uninstall --lang tr
