# 🖥️ SemeloOS

> Custom minimal Linux live OS — boots from USB, desktop + Chrome only, with hardware spoofing

## Features
- ⚡ **Minimal** — Openbox WM + Chromium only
- 🔒 **Stealthy** — Hardware spoofer runs at every boot
- 💾 **Live** — Runs from USB/ISO, nothing installed to disk
- 🎭 **Spoofed** — MAC, hostname, machine-id randomized every boot

## Spoofing Layers

| What | Level | Status |
|------|-------|--------|
| MAC Address | User-space | ✅ Phase 1 |
| Hostname | User-space | ✅ Phase 1 |
| Machine-ID | User-space | ✅ Phase 1 |
| Timezone | User-space | ✅ Phase 1 |
| CPU-ID | Ring 0 (LKM) | 🔜 Phase 2 |
| DMI/SMBIOS | Ring 0 (LKM) | 🔜 Phase 2 |
| Disk Serial | Ring 0 (LKM) | 🔜 Phase 2 |

## Build (GitHub Actions)

1. Fork/push this repo to GitHub
2. Go to **Actions** tab
3. Run **Build SemeloOS ISO** workflow
4. Download the ISO artifact
5. Boot in VMware or flash to USB

## Project Structure

```
SemeloOS/
├── .github/workflows/build.yml   ← CI/CD pipeline
└── semelo-profile/               ← archiso profile
    ├── profiledef.sh             ← ISO metadata
    ├── packages.x86_64           ← package list
    ├── pacman.conf               ← repo config
    └── airootfs/                 ← filesystem overlay
        ├── etc/hostname
        ├── etc/systemd/system/
        │   ├── semelo-spoof.service
        │   └── getty@tty1.service.d/autologin.conf
        ├── root/
        │   ├── .bash_profile     ← auto-start X
        │   ├── .xinitrc          ← start Openbox
        │   └── .config/openbox/autostart  ← start Chrome
        └── usr/local/bin/
            └── semelo-spoof.sh   ← hardware randomizer
```
