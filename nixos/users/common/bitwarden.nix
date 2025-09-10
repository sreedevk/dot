{ pkgs, ... }:
let
  bwfzf-script = import ./scripts/bwfzf.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    bwfzf-script
    rbw
  ];
}
