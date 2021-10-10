#!/bin/bash

connected_displays=( $(xrandr | grep -E '(^|\s)connected($|\s)' | awk '{print $1}') )
port_display="${connected_displays[1]}"
dock_display="${connected_displays[2]}"

if [ ${#connected_displays[@]} -gt 1 ]; then
  xrandr                                                                   \
    --output "$port_display" --mode 1920x1080 --pos 1920x0 --rotate normal \
    --output "$dock_display" --mode 1920x1080 --pos 0x0 --rotate normal
fi
