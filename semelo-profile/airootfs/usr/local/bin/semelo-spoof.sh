#!/usr/bin/env bash
# ============================================================
# SemeloOS Hardware Spoofer - Phase 1 (User-Space)
# Runs at boot to randomize identifiable hardware attributes
# ============================================================

LOG="/var/log/semelo-spoof.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG"
}

log "==================================================="
log " SemeloOS Hardware Spoofer - Starting..."
log "==================================================="

# ─── 1. RANDOMIZE HOSTNAME ────────────────────────────────
ADJECTIVES=("silent" "dark" "swift" "ghost" "void" "nano" "zero" "flux" "iron" "deep")
NOUNS=("node" "host" "unit" "core" "sys" "box" "machine" "server" "agent" "device")

ADJ="${ADJECTIVES[$RANDOM % ${#ADJECTIVES[@]}]}"
NOUN="${NOUNS[$RANDOM % ${#NOUNS[@]}]}"
NUM=$(( RANDOM % 999 + 100 ))
NEW_HOSTNAME="${ADJ}-${NOUN}-${NUM}"

hostnamectl set-hostname "$NEW_HOSTNAME"
log "✅ Hostname spoofed → $NEW_HOSTNAME"

# ─── 2. RANDOMIZE MAC ADDRESS (All interfaces) ────────────
for IFACE in $(ip -o link show | awk -F': ' '{print $2}' | grep -v lo); do
    # Bring interface down
    ip link set "$IFACE" down 2>/dev/null

    # Generate random MAC (locally administered, unicast)
    R1=$(printf '%02x' $(( RANDOM % 256 | 0x02 & ~0x01 )) )
    R2=$(printf '%02x' $(( RANDOM % 256 )))
    R3=$(printf '%02x' $(( RANDOM % 256 )))
    R4=$(printf '%02x' $(( RANDOM % 256 )))
    R5=$(printf '%02x' $(( RANDOM % 256 )))
    R6=$(printf '%02x' $(( RANDOM % 256 )))
    NEW_MAC="${R1}:${R2}:${R3}:${R4}:${R5}:${R6}"

    ip link set "$IFACE" address "$NEW_MAC" 2>/dev/null
    ip link set "$IFACE" up 2>/dev/null

    log "✅ MAC spoofed [$IFACE] → $NEW_MAC"
done

# ─── 3. RANDOMIZE MACHINE-ID ──────────────────────────────
NEW_MACHINE_ID=$(cat /proc/sys/kernel/random/uuid | tr -d '-')
echo "$NEW_MACHINE_ID" > /etc/machine-id
log "✅ Machine-ID spoofed → $NEW_MACHINE_ID"

# ─── 4. SPOOF TIMEZONE (Random common timezone) ───────────
TIMEZONES=("America/New_York" "America/Los_Angeles" "Europe/London" "Europe/Berlin" "Asia/Tokyo" "Asia/Singapore" "Australia/Sydney")
TZ="${TIMEZONES[$RANDOM % ${#TIMEZONES[@]}]}"
timedatectl set-timezone "$TZ" 2>/dev/null
log "✅ Timezone spoofed → $TZ"

log "==================================================="
log " SemeloOS Spoofer - Phase 1 Complete!"
log " Kernel-level spoofer (Phase 2) coming soon..."
log "==================================================="
