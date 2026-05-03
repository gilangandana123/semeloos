#!/bin/bash
# SemeloOS - .xinitrc
# Initializes the X session and launches Openbox

# Set DPI and screen
xrandr --auto

# Disable screen blanking and power saving
xset s off
xset -dpms
xset s noblank

# Start compositor (light transparency/shadow effects)
picom --daemon --config /dev/null \
    --backend glx \
    --vsync \
    --shadow \
    --shadow-radius 10 \
    --shadow-opacity 0.5 &

# Launch Openbox window manager
exec openbox-session
