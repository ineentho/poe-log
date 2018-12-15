#!/bin/bash
set -euxo pipefail

Xvfb :1 -screen 0 800x800x24&

export DISPLAY=:1

x11vnc -q 1>/dev/null 2>&1 &

/home/poe/playonlinux-poe.sh&
/home/poe/click-through-wizard.sh

pkill Xvfb
rm /tmp/.X1-lock
