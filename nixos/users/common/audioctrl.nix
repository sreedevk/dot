{ pkgs, opts, config, ... }:
let
  audio-source-select-script =
    pkgs.writeShellScriptBin "audio-source-select"
      ''
        #!/bin/bash

        available_sources=$(pactl list short sources)

        if [[ -z "$available_sources" ]]; then
            echo "No sources available!"
            exit 1
        fi

        source_list=$(echo "$available_sources" | awk '{print $1 " - " $2}')
        selected_source=$(echo "$source_list" | fzf --prompt="Select an audio source (microphone): ")

        if [[ -z "$selected_source" ]]; then
            echo "No source selected!"
            exit 1
        fi

        source_index=$(echo "$selected_source" | awk '{print $1}')
        pactl set-default-source "$source_index"

        for input in $(pactl list short source-outputs | cut -f1); do
            pactl move-source-output "$input" "$source_index"
        done

        echo "Switched to source: $selected_source"
      '';



  audio-sink-select-script =
    pkgs.writeShellScriptBin "audio-sink-select" ''
      #!/bin/bash

      available_sinks=$(pactl list short sinks)
      if [[ -z "$available_sinks" ]]; then
          echo "No sinks available!"
          exit 1
      fi

      sink_list=$(echo "$available_sinks" | awk '{print $1 " - " $2}')
      selected_sink=$(echo "$sink_list" | fzf --prompt="Select an audio sink: ")

      if [[ -z "$selected_sink" ]]; then
          echo "No sink selected!"
          exit 1
      fi

      sink_index=$(echo "$selected_sink" | awk '{print $1}')
      pactl set-default-sink "$sink_index"

      for input in $(pactl list short sink-inputs | cut -f1); do
          pactl move-sink-input "$input" "$sink_index"
      done

      echo "Switched to sink: $selected_sink"
    '';
in
{
  home.packages = [
    audio-sink-select-script
    audio-source-select-script
  ];
}
