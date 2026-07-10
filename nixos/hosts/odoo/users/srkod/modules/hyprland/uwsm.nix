{
  pkgs,
  opts,
  config,
  ...
}:
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
        export XDG_DATA_DIRS="${config.home.profileDirectory}/share:/usr/local/share:/usr/share:$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share"

        if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
          . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
        fi

        if uwsm check may-start > /dev/null 2>&1; then
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
        export __EGL_EXTERNAL_PLATFORM_CONFIG_DIRS=/usr/share/egl/egl_external_platform.d
        export ELECTRON_OZONE_PLATFORM_HINT=auto
        export GDK_DPI_SCALE=${opts.desktop.scale}
        export GDK_SCALE=${opts.desktop.scale}
        export GTK_THEME=Adwaita:dark
        export MOZ_ENABLE_WAYLAND=1
        export QT_AUTO_SCREEN_SCALE_FACTOR=${opts.desktop.scale}
        export QT_QPA_PLATFORM=wayland
        export QT_SCALE_FACTOR=${opts.desktop.qt_scale_factor}
        export QT_QPA_PLATFORMTHEME=
        export QT_STYLE_OVERRIDE=Fusion
        export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
        export WINIT_X11_SCALE_FACTOR=${opts.desktop.scale}
        export XCURSOR_SIZE=28
        export XDG_CURRENT_DESKTOP=Hyprland
        export XDG_DATA_DIRS="${config.home.profileDirectory}/share:/usr/local/share:/usr/share:$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share"
        export XDG_SESSION_DESKTOP=Hyprland
        export XDG_SESSION_TYPE=wayland
        export __GL_GSYNC_ALLOWED=1
        export __GL_VRR_ALLOWED=1
      '';
    };
  };
}
