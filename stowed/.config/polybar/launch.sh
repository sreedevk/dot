killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if command -v xrandr; then
  xrandr | grep " connected" | while read -r line; do
      display_name=$(echo "$line" | awk '{print $1}')
      resolution=$(echo "$line" | grep -oP "\d{3,}x\d{3,}")
      if [[ -z "$resolution" ]]; then
          continue
      fi
      
      width=$(echo "$resolution" | cut -d'x' -f1)
      height=$(echo "$resolution" | cut -d'x' -f2)

      if [[ $width -gt 1920 || $height -gt 1200 ]]; then
        FONT="Iosevka NF:style=Bold:pixelsize=18;2" HEIGHT=52 MONITOR=$display_name polybar -q main -c ~/.config/polybar/config.ini & disown
      else
        FONT="Iosevka NF:style=Bold:pixelsize=12;2" MONITOR=$display_name polybar -q main -c ~/.config/polybar/config.ini & disown
      fi
  done
else
  FONT="Iosevka NF:style=Bold:pixelsize=12;2" polybar -q main -c ~/.config/polybar/config.ini & disown
fi
