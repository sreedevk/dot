{ pkgs, lib, opts, system, username, ... }: {

  imports = [
    ../../../secrets/mappings.nix
    ../common/base.nix
    ../common/core-packages.nix
    ../common/fastfetch.nix
    ../common/git.nix
    ../common/htop.nix
    ../common/neovim.nix
    ../common/tmux.nix
    ../common/vim.nix
    ../common/zsh.nix
    ./ssh.nix
  ];
}
