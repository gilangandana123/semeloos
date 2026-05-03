#!/bin/bash
# SemeloOS - .bash_profile
# Auto-start X server on TTY1 login

# Only start X on TTY1 and if not already running
if [[ -z "$DISPLAY" ]] && [[ "$(tty)" == "/dev/tty1" ]]; then
    exec startx /root/.xinitrc
fi
