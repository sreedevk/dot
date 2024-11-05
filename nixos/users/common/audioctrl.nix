{ pkgs, opts, config, ... }:
let
  audio-source-select-script =
    pkgs.writeShellScriptBin "audio-source-select"
      ''
        #!/bin/bash

        # List all available sources using pactl
        available_sources=$(pactl list short sources)

        # Check if there are any sources available
        if [[ -z "$available_sources" ]]; then
            echo "No sources available!"
            exit 1
        fi

        # Use awk to format the source list: SourceName [SourceIndex]
        source_list=$(echo "$available_sources" | awk '{print $1 " - " $2}')

        # Use fzf to let the user select a source
        selected_source=$(echo "$source_list" | fzf --prompt="Select an audio source (microphone): ")

        # Check if a source was selected
        if [[ -z "$selected_source" ]]; then
            echo "No source selected!"
            exit 1
        fi

        # Extract the source index from the selected line
        source_index=$(echo "$selected_source" | awk '{print $1}')

        # Switch to the selected source using pactl
        pactl set-default-source "$source_index"

        # If the user wants to move already active audio streams (optional)
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
