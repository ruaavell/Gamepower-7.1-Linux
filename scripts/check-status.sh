#!/usr/bin/env bash
set -euo pipefail
echo "=== PipeWire ==="
pactl info 2>/dev/null | grep -E 'Server Name|Server Version' || true
echo
echo "=== Çıkış aygıtları ==="
pactl list short sinks 2>/dev/null || true
echo
echo "=== Varsayılan çıkış ==="
pactl get-default-sink 2>/dev/null || true
echo
echo "=== Filter-chain servis günlükleri ==="
journalctl --user -u filter-chain -n 35 --no-pager 2>/dev/null || true
journalctl --user -u headset-surround -n 35 --no-pager 2>/dev/null || true
