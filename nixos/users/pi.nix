{ configs, pkgs, secrets, username, ... }: {
  imports = [
    ./common/core-packages.nix
    ./common/misc.nix
    ./common/neovim.nix
    ./common/ssh.nix
    ./common/taskwarrior.nix
    ./common/tmux.nix
    ./common/zsh.nix
  ];
}
