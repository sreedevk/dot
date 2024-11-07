{ pkgs, config, opts, ... }:
let
  hyprconf = import ../opts.nix { inherit pkgs config opts; };
  utils = import ../utils.nix;
in
{
  home.file = {
    ".config/hypr/custom_devs.conf" = {
      enable = true;
      text = ''
        device {
            name        = epic mouse v1
            sensitivity = -0.5
        }
      '';
    };
  };
}
