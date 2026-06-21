{ pkgs, ... }:
pkgs.writeShellScriptBin "gpu" ''
  csv=$(nvidia-smi -i 0 --query-gpu="name,temperature.gpu,memory.total,memory.used,utilization.gpu" --format csv)

  PRODUCT_NAME=$(echo "$csv" | awk -F', ' 'NR==2 {print $1}' | cut -d' ' -f2,3)
  GPU_CUR_TEMP=$(echo "$csv" | awk -F', ' 'NR==2 {print $2}' | tr -d '[:space:]')
  TOTAL_MEMORY=$(echo "$csv" | awk -F', ' 'NR==2 {print $3}' | tr -d '[:space:]' | sed 's/MiB//')
  MEMORY_USAGE=$(echo "$csv" | awk -F', ' 'NR==2 {print $4}' | tr -d '[:space:]' | sed 's/MiB//')
  GPU_USAGE=$(echo "$csv" | awk -F', ' 'NR==2 {print $5}' | tr -d '[:space:]')

  echo "󰟽 $PRODUCT_NAME "$GPU_CUR_TEMP °C" $MEMORY_USAGE/$TOTAL_MEMORY MiB · $GPU_USAGE"

  exit 0
''
