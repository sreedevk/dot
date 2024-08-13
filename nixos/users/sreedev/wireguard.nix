{ pkgs, opts, username, ... }:
let
  wireguard =
    pkgs.writeShellScriptBin "wireguard.sh" ''
      #!/usr/bin/env bash

      set -eo pipefail

      wireguard-help() {
        echo "wireguard.sh"
        echo "usage:"
        echo "  connect to a wireguard server"
        echo "    sudo wireguard.sh up"
        echo "  disconnect from a wireguard server"
        echo "    sudo wireguard.sh down"
      }

      wireguard-connect() {
        configuration_path=$(ls /etc/wireguard/*.conf | fzf)
        configuration_file=$(basename "$configuration_path")
        configuration_name=$\{configuration_file%.*\}

        wg-quick up $configuration_name
      }

      wireguard-disconnect() {
        interface_to_disconnect=$(ip -o link show | awk -F': ' '{print $2}' | grep -vE '^lo$|^wlan0$|^en0*|^wlp*' | fzf)
        wg-quick down $interface_to_disconnect
      }

      case $1 in
        up)
          wireguard-connect
          ;;
        down)
          wireguard-disconnect
          ;;
        *)
          wireguard-help
          ;;
      esac
    '';
in
{
  home.packages = [ wireguard ];
}
