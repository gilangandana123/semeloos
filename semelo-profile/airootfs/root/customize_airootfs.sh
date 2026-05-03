#!/bin/bash
# SemeloOS - customize_airootfs.sh
# Runs INSIDE the chroot AFTER pacstrap installs packages
# This is the CORRECT place to post-configure the live system

set -e

echo "==> [SemeloOS] Running customize_airootfs.sh inside chroot..."

# Remove root password (pacstrap locks it with '!')
# This is the ONLY reliable way since shadow gets overwritten by packages
passwd -d root
echo "==> [SemeloOS] Root password removed."

# Verify
echo "==> [SemeloOS] Shadow entry for root:"
grep ^root /etc/shadow

echo "==> [SemeloOS] Done!"
