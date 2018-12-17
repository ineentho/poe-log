#!/bin/bash
set -euxo pipefail

Xvfb :1 -screen 0 800x600x24&

export DISPLAY=:1

x11vnc -q 1>/dev/null 2>&1 &

cd /home/poe

# First run will crash, causing the second run to check files
WINEPREFIX=$HOME/.PlayOnLinux/wineprefix/pathofexile/ ~/.PlayOnLinux/wine/linux-x86/4.0-rc1/bin/wine PlayOnLinux\'s\ virtual\ drives/pathofexile/drive_c/Program\ Files/Grinding\ Gear\ Games/Path\ of\ Exile/PathOfExile.exe

WINEPREFIX=$HOME/.PlayOnLinux/wineprefix/pathofexile/ ~/.PlayOnLinux/wine/linux-x86/4.0-rc1/bin/wine PlayOnLinux\'s\ virtual\ drives/pathofexile/drive_c/Program\ Files/Grinding\ Gear\ Games/Path\ of\ Exile/PathOfExile.exe &

/home/poe/launcher/click-through-patcher.py

pkill PathOfExile.exe

pkill Xvfb
rm /tmp/.X1-lock
