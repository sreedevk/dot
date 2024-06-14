{ configs, pkgs, secrets, username, ... }: {
  imports = [
    ./common/misc.nix
    ./common/packages/cli.nix
    ./common/packages/tmux.nix
    ./common/ssh.nix
    ./common/systemd.nix
    ./common/taskwarrior.nix
    ./common/zsh.nix
  ];

  home.packages = with pkgs; [
    asdf-vm
    ruby
    zsh
  ];

  programs.zsh.enable = true;
}
