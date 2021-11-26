#!/bin/sh

# TIME
LOCAL_TIME=$(date '+%d/%m/%Y %I:%M:%S %p %Z')
OFFSHORE_TIME=$(TZ=America/New_York date '+%d/%m/%Y %I:%M:%S %p %Z') 

# WIRELESS
WIRELESS_INTERFACE=$(cat /proc/net/wireless | tail -n 1 | awk '{print $1}' | tr -d :)
IP_ADDR="$(ip -f inet addr show $WIRELESS_INTERFACE | awk '/inet / {print $2}')"

# BATTERY
BATTERY_PERCENTAGE=$(upower -e | grep BAT0 | xargs -Ix upower -i x | grep percentage | awk '{print $2}')
BATTERY_STATUS=$(upower -e | grep BAT0 | xargs -Ix upower -i x | grep state | awk '{print $2}')
BATTERY_INFO="$BATTERY_PERCENTAGE $BATTERY_STATUS"

# GPU
GPU_INFO=$(nvidia-smi -q)
PRODUCT_NAME="$(awk '/Product Name/ {print $4FS$5}' <<< $GPU_INFO)"
MEMORY_USAGE="$(awk '/Used/ {print $3;exit}' <<< $GPU_INFO)"
TOTAL_MEMORY="$(awk '/Total/ {print $3FS$4;exit}' <<< $GPU_INFO)"
GPU_TEMP="$(awk '/GPU Current Temp/ {print $5"°"$6;exit}' <<< $GPU_INFO)"

echo "$PRODUCT_NAME: $GPU_TEMP $MEMORY_USAGE/$TOTAL_MEMORY | $WIRELESS_INTERFACE: $IP_ADDR | BAT: $BATTERY_INFO | $OFFSHORE_TIME | $LOCAL_TIME"
