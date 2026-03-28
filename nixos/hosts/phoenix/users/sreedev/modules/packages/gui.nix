{ config, pkgs, ... }:
let
  gpu-screen-recorder-gtk-wrapped = pkgs.symlinkJoin {
    name = "gpu-screen-recorder-gtk-wrapped";
    paths = [ pkgs.gpu-screen-recorder-gtk ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/gpu-screen-recorder-gtk \
        --set LIBGL_DRIVERS_PATH /usr/lib/dri \
        --set __EGL_VENDOR_LIBRARY_DIRS /usr/share/glvnd/egl_vendor.d \
        --set GBM_BACKENDS_PATH /usr/lib/gbm
    '';
  };
in
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
            discord
            easyeffects
            feishin
            ffmpegthumbnailer
            furnace
            gf
            gimp3-with-plugins
            gnome-calculator
            gpu-screen-recorder
            gpu-screen-recorder-gtk-wrapped
            jellyfin-desktop
            krita
            libreoffice-fresh
            localsend
            nemo-with-extensions
            nvtopPackages.full
            nwg-look
            obsidian
            openttd
            pavucontrol
            radicle-desktop
            signal-desktop
            slack
            tor-browser
            upscayl
            wofi
            xpipe
          ]
        );
    in
    builtins.concatLists [
      iGPUPackages
      dGPUPackages
      xGPUPackages
    ];
}
