{ pkgs, secrets, lib, inputs, opts, system, username, ... }: {
  imports = [
    ./common/autorandr.nix
    ./common/autotiling.nix
    ./common/awscli.nix
    ./common/core-packages.nix
    ./common/dunst.nix
    ./common/firefox.nix
    ./common/fontconfig.nix
    ./common/keybase.nix
    ./common/keyboard.nix
    ./common/misc.nix
    ./common/ssh.nix
    ./common/stylix.nix
    ./common/taskwarrior.nix
    ./common/tmux.nix
    ./common/x86-packages.nix
    ./common/zsh.nix
  ];

  home.packages = with pkgs; [
    arandr
    autorandr
    autotiling
    awscli2
    cinnamon.nemo-with-extensions
    dbeaver-bin
    droidcam
    dunst
    emacs
    floorp
    jira-cli-go
    spotify
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
  ];
}
