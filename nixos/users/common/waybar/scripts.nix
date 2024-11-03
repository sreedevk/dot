{ pkgs, ... }:
{
  dnd-script =
    pkgs.writeShellScriptBin "dnd" ''
      [[ "$(${pkgs.dunst}/bin/dunstctl is-paused)" == "true" ]] && echo " " || echo " "
    '';

  cpu-temp-script =
    pkgs.writeShellScriptBin "cpu-temp" ''
      echo "$(sensors | grep "Package" | awk '{print $4}')"
    '';

  gpu-script =
    pkgs.writeShellScriptBin "gpu" ''
      csv=$(nvidia-smi -i 0 --query-gpu="name,temperature.gpu,memory.total,memory.used" --format csv)

      PRODUCT_NAME=$(echo "$csv" | awk -F', ' 'NR==2 {print $1}' | cut -d' ' -f2,3)
      GPU_CUR_TEMP=$(echo "$csv" | awk -F', ' 'NR==2 {print $2}' | tr -d '[:space:]')
      MEMORY_USAGE=$(echo "$csv" | awk -F', ' 'NR==2 {print $4}' | tr -d '[:space:]' | sed 's/MiB//')
      TOTAL_MEMORY=$(echo "$csv" | awk -F', ' 'NR==2 {print $3}' | tr -d '[:space:]' | sed 's/MiB//')

      echo "$PRODUCT_NAME "$GPU_CUR_TEMP °C" $MEMORY_USAGE/$TOTAL_MEMORY MiB"

      exit 0
    '';

  memory-script =
    pkgs.writeShellScriptBin "memory" ''
      echo "$(free --giga --human | awk 'NR==2 {printf "%.2f/%.2f G", $3, $2}')"
    '';
}
