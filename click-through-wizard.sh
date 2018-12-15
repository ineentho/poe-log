#!/bin/bash
set -euxo pipefail

sleep 1

echo Waiting for the installer to open
xdotool search --sync --name --limit 1 'PlayOnLinux'
sleep 1

echo Clicking next
xdotool mousemove 520 580
xdotool click 1

echo Waiting for mono installer
mono_installer=$(xdotool search --sync --name --limit 1 'Wine Mono Installer')

echo Clicking return
xdotool key --window $mono_installer Return

echo Waiting for gecko installer
gecko_installer=$(xdotool search --sync --name --limit 1 'Wine Gecko Installer')

echo Clicking return
xdotool key --window $gecko_installer Return

echo Waiting for POE installer
poe_installer=$(xdotool search --sync --name --limit 1 'Path of Exile Setup')
sleep 1

echo Agree to the terms
xdotool mousemove 425 647
xdotool click 1

echo Clicking install
xdotool mousemove 585 675
xdotool click 1

sleep 5

echo Clicking close
xdotool mousemove 665 675
xdotool click 1
