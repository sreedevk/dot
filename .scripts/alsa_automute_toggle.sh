#!/usr/bin/zsh

# Script that toggles mute on Alsa. You can map this script to a keybinding on i3wm to mute & unmute audio

export current_status="$(amixer -c 0 sget "Auto-Mute Mode" | grep Item0 | awk '{print $2}')"
if [[ $current_status == "'Enabled'" ]]
then
  amixer -c 0 sset "Auto-Mute Mode" Disabled
else
  amixer -c 0 sset "Auto-Mute Mode" Enabled
fi
