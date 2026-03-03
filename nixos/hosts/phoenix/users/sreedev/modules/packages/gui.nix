{ config, pkgs, ... }:
{
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
            easyeffects
            feishin
            ffmpegthumbnailer
            furnace
            gf
            gimp3-with-plugins
            gnome-calculator
            gpu-screen-recorder
            gpu-screen-recorder-gtk
            jellyfin-desktop
            libreoffice-fresh
            localsend
            nemo-with-extensions
            nvtopPackages.full
            nwg-look
            obsidian
            openttd
            pavucontrol
            signal-desktop
            slack
            tor-browser
            upscayl
            wofi
            xpipe
            zed-editor
          ]
        );
    in
    builtins.concatLists [
      iGPUPackages
      dGPUPackages
      xGPUPackages
    ];
}
