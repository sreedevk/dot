{ configs, pkgs, secrets, username, ... }: {
  imports = [
    ./common/base.nix
    ./common/core-packages.nix
    ./common/fastfetch.nix
    ./common/git.nix
    ./common/htop.nix
    ./common/neovim.nix
    ./common/ssh.nix
    ./common/taskwarrior.nix
    ./common/tmux.nix
    ./common/zsh.nix
  ];
}
