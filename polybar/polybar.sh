#!/usr/bin/env sh

killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    if [[ $m == *DP-1-3* ]]
    then
      TRAY_POSITION=right MONITOR=$m polybar --reload san &
    else
      MONITOR=$m polybar --reload san &
    fi
  done
else
 TRAY_POSITION=right polybar --reload san &
fi
