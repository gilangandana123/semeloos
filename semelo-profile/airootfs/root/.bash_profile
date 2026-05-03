#!/bin/bash
# SemeloOS - .bash_profile
# Auto-start X server on TTY1 login

# Only start X on TTY1 and if not already running
if [[ -z "$DISPLAY" ]] && [[ "$(tty)" == "/dev/tty1" ]]; then
    # Log output so we can debug issues
    startx /root/.xinitrc -- :0 2>&1 | tee /var/log/semelo-startx.log
    echo ""
    echo "=== X server exited. See /var/log/semelo-startx.log for details ==="
    echo "=== Type 'startx' to retry or check log with: cat /var/log/semelo-startx.log ==="
fi
