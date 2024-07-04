{ configs, pkgs, secrets, username, ... }: {
  imports = [
    ./common/cargo.nix
    ./common/misc.nix
    ./common/neovim.nix
    ./common/packages/cli.nix
    ./common/ssh.nix
    ./common/taskwarrior.nix
    ./common/tmux.nix
    ./common/zsh.nix
  ];
}
