{ pkgs, secrets, lib, inputs, opts, system, username, ... }: {
  imports = [
    ./common/autorandr.nix
    ./common/autotiling.nix
    ./common/awscli.nix
    ./common/core-packages.nix
    ./common/dunst.nix
    ./common/fastfetch.nix
    ./common/firefox.nix
    ./common/fontconfig.nix
    ./common/htop.nix
    ./common/i3.nix
    ./common/keybase.nix
    ./common/keyboard.nix
    ./common/misc.nix
    ./common/newsboat.nix
    ./common/ssh.nix
    ./common/stylix.nix
    ./common/taskwarrior.nix
    ./common/tmux.nix
    ./common/x86-packages.nix
    ./common/zsh.nix
  ];

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
    arandr
    autorandr
    autotiling
    awscli2
    brightnessctl
    cinnamon.nemo-with-extensions
    dbeaver-bin
    droidcam
    dunst
    emacs
    feh
    gimp-with-plugins
    jira-cli-go
    joplin-desktop
    libreoffice-fresh
    lmms
    nsxiv
    openttd
    playerctl
    python311Packages.i3ipc
    qflipper
    rofi
    slack
    spotify
    sxiv
    zathura
  ];
}
