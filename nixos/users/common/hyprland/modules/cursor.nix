{ pkgs, config, opts, ... }:
let
  hyprconf = import ../opts.nix { inherit pkgs config opts; };
  utils = import ../utils.nix;
in
{
  home.file = {
    ".config/hypr/cursor.conf" = {
      enable = true;
      text = ''
        cursor:no_hardware_cursors = true
      '';
    };
  };
}
