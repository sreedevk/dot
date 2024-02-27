killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    if [[ "$m" == "DP-1-3" ]]; then
      FONT="Iosevka NF:style=Bold:pixelsize=18;2" HEIGHT=52 MONITOR=$m polybar -q main -c ~/.config/polybar/config.ini & disown
    else
      FONT="Iosevka NF:style=Bold:pixelsize=12;2" MONITOR=$m polybar -q main -c ~/.config/polybar/config.ini & disown
    fi
  done
else
  FONT="Iosevka NF:style=Bold:pixelsize=12;2" polybar -q main -c ~/.config/polybar/config.ini & disown
fi
