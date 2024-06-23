{ pkgs, secrets, lib, inputs, opts, system, username, ... }: {
  imports = [
    ./common/autorandr.nix
    ./common/autotiling.nix
    ./common/awscli.nix
    ./common/dunst.nix
    ./common/firefox.nix
    ./common/fontconfig.nix
    ./common/misc.nix
    ./common/packages/cli.nix
    ./common/packages/gui.nix
    ./common/tmux.nix
    ./common/ssh.nix
    ./common/stylix.nix
    ./common/taskwarrior.nix
    ./common/zsh.nix
  ];
}
