#!/bin/bash
# SemeloOS - .xinitrc
# Initializes the X session and launches Openbox

# Set DPI and screen
xrandr --auto

# Disable screen blanking and power saving
xset s off
xset -dpms
xset s noblank

# Start compositor (xrender backend - compatible with VMware)
picom --daemon --config /dev/null \
    --backend xrender \
    --shadow \
    --shadow-radius 8 \
    --shadow-opacity 0.4 &

# Launch Openbox window manager
exec openbox-session
