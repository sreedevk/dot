{ config, pkgs, ... }:
{

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  gtk = {
    gtk4.theme = config.gtk.theme;
  };

  home.packages = with pkgs; [
    audacity
    bitwarden-desktop
    clipse
    cobang
    dbeaver-bin
    discord
    easyeffects
    feishin
    ffmpegthumbnailer
    furnace
    gf
    gimp3-with-plugins
    gnome-calculator
    krita
    libreoffice-fresh
    localsend
    nemo-with-extensions
    nvidia-vaapi-driver
    nvtopPackages.full
    nwg-look
    obsidian
    openttd
    pavucontrol
    radicle-desktop
    sageWithDoc
    signal-desktop
    slack
    tor-browser
    upscayl
    wofi
    xpipe
  ];
}
