{ pkgs, ... }:
let
  hyprlaunch = pkgs.writeShellScriptBin "hyprlaunch" ''
    if uwsm check may-start; then
      exec uwsm start hyprland-uwsm.desktop
    fi
  '';
in
{

  home.packages = [ hyprlaunch ];

  home.file = {
    ".profile" = {
      enable = true;
      recursive = false;
      target = ".profile";
      executable = true;
      text = ''
        export XDG_DATA_DIRS="$HOME/.nix-profile/share:$XDG_DATA_DIRS"
        if uwsm check may-start; then
          exec uwsm start hyprland-uwsm.desktop
        fi
      '';
    };

    ".config/uwsm/env-hyprland" = {
      enable = true;
      executable = true;
      text = ''
        # HYPR* and AQ_* variables
        export AQ_DRM_DEVICES="/dev/dri/card0:/dev/dri/card1"
        export HYPRCURSOR_SIZE=28
        export HYPRCURSOR_THEME=rose-pine-hyprcursor
      '';
    };

    ".config/uwsm/env" = {
      enable = true;
      executable = true;
      text = ''
        export EGL_PLATFORM=wayland
        export ELECTRON_OZONE_PLATFORM_HINT=auto
        export GBM_BACKEND=nvidia-drm
        export GDK_DPI_SCALE=1
        export GDK_SCALE=1
        export GTK_THEME=Adwaita:dark
        export LIBVA_DRIVER_NAME=nvidia
        export MOZ_ENABLE_WAYLAND=1
        export QT_AUTO_SCREEN_SCALE_FACTOR=1
        export QT_QPA_PLATFORM=xcb
        export QT_SCALE_FACTOR=1
        export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
        export WINIT_X11_SCALE_FACTOR=1
        export XCURSOR_SIZE=28
        export XDG_CURRENT_DESKTOP=Hyprland
        export XDG_DATA_DIRS="$HOME/.nix-profile/share:$XDG_DATA_DIRS"
        export XDG_SESSION_DESKTOP=Hyprland
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
