#!/bin/sh

# TIME
LOCAL_TIME=$(date '+%d/%m/%Y %I:%M:%S %p %Z')
OFFSHORE_TIME=$(TZ=Asia/Kolkata date '+%d/%m/%Y %I:%M:%S %p %Z') 

# WIRELESS
WIRELESS_INTERFACE=$(ip link show | grep -E '^[0-9]' | awk '{print $2}' | tr -d : | head -n 2 | tail -n 1)
IP_ADDR="$(ip -f inet addr show $WIRELESS_INTERFACE | grep inet | awk '{print $2}' | cut -f1 -d"/")"

# CPU
CPU_TEMPERATURE="$(vcgencmd measure_temp | awk '{split($0,a,"="); print a[2]}')"

echo "CPU TEMP: $CPU_TEMPERATUREºC | $WIRELESS_INTERFACE: $IP_ADDR | $OFFSHORE_TIME | $LOCAL_TIME"
