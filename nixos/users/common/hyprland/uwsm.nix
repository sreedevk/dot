{ pkgs, ... }:
let
  hypr-launch-script = pkgs.writeShellScriptBin "hyprlaunch" ''
    if uwsm check may-start && uwsm select; then
      exec uwsm start default
    fi
  '';
in
{
  home.packages = [ hypr-launch-script ];

  home.file = {
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
