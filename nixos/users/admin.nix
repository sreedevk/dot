{ configs, pkgs, secrets, opts, username, ... }: {
  imports = [
    ./common/beets.nix
    ./common/cargo.nix
    ./common/core-packages.nix
    ./common/keybase.nix
    ./common/misc.nix
    ./common/neovim.nix
    ./common/ssh.nix
    ./common/taskwarrior.nix
    ./common/tmux.nix
    ./common/x86-packages.nix
    ./common/zsh.nix
  ];
}
