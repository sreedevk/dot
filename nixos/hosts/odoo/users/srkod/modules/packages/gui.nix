{ config, pkgs, ... }:
{

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  gtk = {
    gtk4.theme = config.gtk.theme;
  };

  home.packages =
    let
      xGPUPackages = [];
      iGPUPackages =
        map (ipkg: (config.lib.nixGL.wrap ipkg)) [];
      dGPUPackages =
        with builtins;
        map (ipkg: (config.lib.nixGL.wrapOffload ipkg)) (
          with pkgs;
          [ 
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
            krita
            libreoffice-fresh
            localsend
            nemo-with-extensions
            nvtopPackages.full
            nwg-look
            pavucontrol
          ]
        );
    in
    builtins.concatLists [
      iGPUPackages
      dGPUPackages
      xGPUPackages
    ];
}
