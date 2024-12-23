{ pkgs, config, opts, ... }:
let
  hyprconf = import ../opts.nix { inherit pkgs config opts; };
  utils = import ../utils.nix;
in
{
  home.file = {
    ".config/hypr/general.conf" = {
      enable = true;
      text = builtins.concatStringsSep "\n"
        (utils.genNested "general" hyprconf.general);
    };
  };
}
