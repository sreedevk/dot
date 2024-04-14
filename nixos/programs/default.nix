{ config, pkgs, ... }: {
  imports = [
    ./git.nix
    ./tmux.nix
  ];
}
