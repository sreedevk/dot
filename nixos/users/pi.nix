{ configs, pkgs, secrets, username, ... }: {
  imports = [
    ./common/misc.nix
    ./common/neovim.nix
    ./common/packages/cargo.nix
    ./common/packages/cli.nix
    ./common/packages/tmux.nix
    ./common/ssh.nix
    ./common/taskwarrior.nix
    ./common/zsh.nix
  ];
}
