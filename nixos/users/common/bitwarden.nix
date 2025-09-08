{ pkgs, ... }:
let
  bwfzf-script = import ./bwfzf.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    bwfzf-script
    rbw
  ];
}
