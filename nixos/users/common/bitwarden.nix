{ pkgs, config, ... }:
let
  bitwaden-fzf-script = import ./bwfzf.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    (config.lib.nixGL.wrap pkgs.bitwarden-desktop)
    bitwaden-fzf-script
    bitwarden-cli
  ];
}
