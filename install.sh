#!/usr/bin/env bash
set -euo pipefail

# Gamepower Ranger Virtual 7.1 for Linux
# Uses the MIT-licensed headset-surround-linux PipeWire/HRTF installer.
# Upstream source is pinned to a specific commit for reproducibility.

UPSTREAM="https://raw.githubusercontent.com/gok8lp/headset-surround-linux/bd9c465fde8b42da19c6fbba5623e4467624eb5c/install.sh"
TMP_DIR="$(mktemp -d)"
cleanup() { rm -rf "$TMP_DIR"; }
trap cleanup EXIT

if [[ "${EUID}" -eq 0 ]]; then
  echo "Root olarak çalıştırma. Normal kullanıcı hesabınla çalıştır."
  exit 1
fi

if ! command -v pipewire >/dev/null 2>&1; then
  echo "HATA: PipeWire bulunamadı. Arch için: sudo pacman -S pipewire pipewire-pulse wireplumber"
  exit 1
fi

if ! command -v curl >/dev/null 2>&1 && ! command -v wget >/dev/null 2>&1; then
  echo "curl veya wget gerekli. Arch için: sudo pacman -S curl"
  exit 1
fi

echo "Gamepower Ranger için PipeWire sanal 7.1 kurulumu"
echo "Açık kaynak motor: gok8lp/headset-surround-linux (MIT)"
echo
echo "Kurulum, gerçek kulaklık çıkışını seçmeni isteyecek."
echo "Gamepower Ranger USB çıkışını seç. Varsayılan çıkışın Surround 7.1 yapılacak."
echo "Yeni sanal çıkışın başlangıç seviyesi güvenlik için %30 olacak."
echo

if command -v curl >/dev/null 2>&1; then
  curl -fL --retry 2 "$UPSTREAM" -o "$TMP_DIR/upstream-install.sh"
else
  wget -O "$TMP_DIR/upstream-install.sh" "$UPSTREAM"
fi

bash -n "$TMP_DIR/upstream-install.sh"
bash "$TMP_DIR/upstream-install.sh" --surround --lang tr
