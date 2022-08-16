#!/bin/bash

# TITLE: i3wm Autostart Script
# DESCRIPTION: This script will setup displays automatically when i3wm startsup

connected_displays=( $(xrandr | grep -E '(^|\s)connected($|\s)' | awk '{print $1}') )
port_display="${connected_displays[1]}"
dock_display="${connected_displays[2]}"

if [ ${#connected_displays[@]} -gt 1 ]; then
  xrandr                                                                                          \
    --output "${connected_displays[0]}" --scale 2x2 --mode 1920x1080 --pos 3840x0 --rotate normal \
    --output "${connected_displays[1]}" --scale 2x2 --mode 1920x1080 --pos 0x0 --rotate normal --rate 120
else
    xrandr --output ${connected_displays[0]} --mode 1920x1080 --scale 2x2 --pos 0x0 --rotate normal
fi

