#!/usr/bin/env bash
# ============================================================
# SemeloOS - customize_airootfs.sh
# Runs inside chroot during ISO build to configure the system
# ============================================================

set -e -u

# ─── Enable Systemd Services ──────────────────────────────
systemctl enable NetworkManager
systemctl enable semelo-spoof

# ─── Set Root Password (no password for live) ─────────────
passwd -d root

# ─── Create necessary directories ─────────────────────────
mkdir -p /root/.config/openbox
mkdir -p /var/log

# ─── Set correct permissions for scripts ──────────────────
chmod 755 /usr/local/bin/semelo-spoof.sh

# ─── Configure pacman (optional cleanup) ──────────────────
# Remove package cache to reduce ISO size
pacman -Scc --noconfirm || true

# ─── Done ─────────────────────────────────────────────────
echo "✅ SemeloOS airootfs customization complete!"
