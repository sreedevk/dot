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
    gf
    gimp3-with-plugins
    gnome-calculator
    handy
    krita
    libreoffice-fresh
    localsend
    nemo-with-extensions
    nvtopPackages.full
    nwg-look
    pavucontrol
  ];
}
