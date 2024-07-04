{ configs, pkgs, secrets, opts, username, ... }: {
  imports = [
    ./common/beets.nix
    ./common/cargo.nix
    ./common/keybase.nix
    ./common/misc.nix
    ./common/neovim.nix
    ./common/packages/cli.nix
    ./common/ssh.nix
    ./common/taskwarrior.nix
    ./common/tmux.nix
    ./common/zsh.nix
  ];
}
