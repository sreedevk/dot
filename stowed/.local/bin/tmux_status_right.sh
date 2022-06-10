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

# CPU
CPU_TEMPERATURES="$(sensors -u | grep input | grep temp | awk '{print $2}')"
AVERAGE_CPU_TEMPERATURE="$(echo $CPU_TEMPERATURES | jq -s 'add / length | round')"

echo "CPU TEMP: $AVERAGE_CPU_TEMPERATUREºC | $WIRELESS_INTERFACE: $IP_ADDR | BAT: $BATTERY_INFO | $OFFSHORE_TIME | $LOCAL_TIME"
