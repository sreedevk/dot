#!/bin/sh

csv=$(nvidia-smi -i 0 --query-gpu="name,temperature.gpu,memory.total,memory.used" --format csv)

# Extracting data from CSV
PRODUCT_NAME=$(echo "$csv" | awk -F', ' 'NR==2 {print $1}' | cut -d' ' -f2,3)
GPU_CUR_TEMP=$(echo "$csv" | awk -F', ' 'NR==2 {print $2}' | tr -d '[:space:]')
MEMORY_USAGE=$(echo "$csv" | awk -F', ' 'NR==2 {print $4}' | tr -d '[:space:]' | sed 's/MiB//')
TOTAL_MEMORY=$(echo "$csv" | awk -F', ' 'NR==2 {print $3}' | tr -d '[:space:]' | sed 's/MiB//')

echo "$PRODUCT_NAME "${GPU_CUR_TEMP}°C" $MEMORY_USAGE/$TOTAL_MEMORY MiB"

exit 0
