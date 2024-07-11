{ pkgs, secrets, lib, inputs, opts, system, username, ... }: {

  imports = [
    ./common/core-packages.nix
    ./common/fastfetch.nix
    ./common/keybase.nix
    ./common/misc.nix
    ./common/neovim.nix
    ./common/tmux.nix
    ./common/zsh.nix
  ];
}
