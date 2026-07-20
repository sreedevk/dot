{ config, pkgs, ... }:
{

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  gtk = {
    gtk4.theme = config.gtk.theme;
  };

  home.packages = with pkgs; [
    audacity             # audio editor
    bitwarden-desktop    # password manager
    clipse               # useful clipboard manager tui for unix
    cobang               # qr code scanner desktop app for linux
    dbeaver-bin          # database client
    discord              # messenger
    easyeffects          # linux audio effects
    feishin              # subsonic music player
    ffmpegthumbnailer    # video thumbnail creator
    gf                   # gnu frontend
    gimp3-with-plugins   # image editor
    gnome-calculator     # calculator
    handy                # voice to text input
    krita                # free and open source painting application
    libreoffice-fresh    # office suite
    localsend            # open source cross-platform alternative to airdrop
    nemo-with-extensions # file explorer
    nvtopPackages.full   # top for gpu
    nwg-look             # gtk3 theme editor
    pavucontrol          # pulse audio volume control
  ];
}
