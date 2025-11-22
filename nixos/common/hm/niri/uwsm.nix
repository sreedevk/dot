{ pkgs
, opts
, ...
}:
let
  xniri = pkgs.writeShellScriptBin "xniri" ''
    if uwsm check may-start; then
      exec uwsm start niri.desktop
    fi
  '';
in
{

  home.packages = [ xniri ];

  home.file = {
    ".profile" = {
      enable = true;
      recursive = false;
      target = ".profile";
      executable = true;
      text = ''
        export XDG_DATA_DIRS="$HOME/.nix-profile/share:$XDG_DATA_DIRS"

        if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
          . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
        fi

        if uwsm check may-start; then
          exec uwsm start niri.desktop
        fi
      '';
    };

    ".config/uwsm/env" = {
      enable = true;
      executable = true;
      text = ''
        export EGL_PLATFORM=wayland
        export ELECTRON_OZONE_PLATFORM_HINT=auto
        export GBM_BACKEND=nvidia-drm
        export GDK_DPI_SCALE=${opts.desktop.scale}
        export GDK_SCALE=${opts.desktop.scale}
        export GTK_THEME=Adwaita:dark
        export LIBVA_DRIVER_NAME=nvidia
        export MOZ_ENABLE_WAYLAND=1
        export QT_AUTO_SCREEN_SCALE_FACTOR=${opts.desktop.scale}
        export QT_QPA_PLATFORM=wayland
        export QT_SCALE_FACTOR=${opts.desktop.qt_scale_factor}
        export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
        export WINIT_X11_SCALE_FACTOR=${opts.desktop.scale}
        export XCURSOR_SIZE=28
        export XDG_CURRENT_DESKTOP=niri
        export XDG_DATA_DIRS="$HOME/.nix-profile/share:$XDG_DATA_DIRS"
        export XDG_SESSION_DESKTOP=niri
        export XDG_SESSION_TYPE=wayland
        export __GLX_VENDOR_LIBRARY_NAME=nvidia
        export __GL_GSYNC_ALLOWED=1
        export __GL_VRR_ALLOWED=1
        export __NV_PRIME_RENDER_OFFLOAD=1
        export __VK_LAYER_NV_optimus=NVIDIA_only
      '';
    };
  };
}
