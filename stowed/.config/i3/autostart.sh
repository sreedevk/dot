#!/bin/bash

# Copyright 2021 (c) Sreedev Kodichath

# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
# associated documentation files (the "Software"), to deal in the Software without restriction, 
# including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all copiesor substantial
# portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
# LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

connected_displays=( $(xrandr | grep -E '(^|\s)connected($|\s)' | awk '{print $1}') )
port_display="${connected_displays[1]}"
dock_display="${connected_displays[2]}"

setxkbmap -layout us,apl -variant,dyalog -option grp:lswitch

if [ ${#connected_displays[@]} -gt 1 ]; then
  xrandr                                                                                          \
    --output "${connected_displays[0]}" --scale 2x2 --mode 1920x1080 --pos 5600x0 --rotate normal \
    --output "${connected_displays[1]}" --scale 2x2 --mode 2560x1440 --pos 0x0 --rotate normal --rate 120
else
    xrandr --output ${connected_displays[0]} --mode 1920x1080 --scale 2x2 --pos 0x0 --rotate normal
fi
