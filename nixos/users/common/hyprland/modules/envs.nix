{ pkgs, config, opts, ... }:
let
  hyprconf = import ../opts.nix { inherit pkgs config opts; };
  utils = import ../utils.nix;
in
{
  home.file = {
    ".config/hypr/envs.conf" = {
      enable = true;
      text = utils.genEnvs hyprconf.envs;
    };
  };
}
