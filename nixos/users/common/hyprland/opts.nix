{ pkgs, config, ... }:
{
  envs = {
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __NV_PRIME_RENDER_OFFLOAD = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    XCURSOR_SIZE = "28";
    HYPRCURSOR_SIZE = "28";
    AQ_DRM_DEVICES = "/dev/dri/card0:/dev/dri/card1";
    XDG_DATA_DIRS = "$HOME/.nix-profile/share:$XDG_DATA_DIRS";
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_SCALE_FACTOR = "1";
    WINIT_X11_SCALE_FACTOR = "1";
  };

  monitors = [
    {
      name = "eDP-1";
      desc = "AU Optronics 0xF99A";
      resolution = { x = 1920; y = 1200; };
      position = { x = 0; y = 1080; };
      rate = 60;
      scale = 1;
    }
    {
      name = "DP-3";
      desc = "XEC ES-24X3A 0x00000022";
      resolution = { x = 1920; y = 1080; };
      position = { x = 0; y = 0; };
      rate = 100.00;
      scale = 1;
    }
    {
      name = "DP-2";
      desc = "LG Electronics LG Ultra HD 0x00073F78";
      resolution = { x = 3840; y = 2160; };
      position = { x = 1920; y = 0; };
      rate = 60;
      scale = 1.6;
    }
  ];

  binds = [
    { mod = "SUPER"; keys = "Return"; dispatcher = "exec"; args = "${config.programs.alacritty.package}/bin/alacritty"; }
    { mod = "SUPER"; keys = "KP_Enter"; dispatcher = "exec"; args = "${config.programs.alacritty.package}/bin/alacritty"; }
    { mod = "SUPER SHIFT"; keys = "Q"; dispatcher = "killactive"; args = ""; }
    { mod = "SUPER SHIFT"; keys = "E"; dispatcher = "exit"; args = ""; }
    { mod = "SUPER"; keys = "Tab"; dispatcher = "exec"; args = "${pkgs.rofi}/bin/rofi -show window"; }
    { mod = "SUPER SHIFT"; keys = "Space"; dispatcher = "togglefloating"; args = ""; }
    { mod = "SUPER"; keys = "F"; dispatcher = "fullscreen"; args = ""; }
    { mod = "SUPER"; keys = "D"; dispatcher = "exec"; args = "${pkgs.rofi}/bin/rofi -show drun"; }
    { mod = "SUPER SHIFT"; keys = "C"; dispatcher = "exec"; args = "hyprctl reload"; }
    { mod = "SUPER SHIFT"; keys = "S"; dispatcher = "exec"; args = "${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | wl-copy"; }


    { mod = "CTRL"; keys = "Space"; dispatcher = "exec"; args = "${pkgs.dunst}/bin/dunstctl close-all"; }
    { mod = "SUPER"; keys = "N"; dispatcher = "exec"; args = "${pkgs.dunst}/bin/dunstctl set-paused toggle"; }
    { mod = "SUPER"; keys = "H"; dispatcher = "movefocus"; args = "l"; }
    { mod = "SUPER"; keys = "L"; dispatcher = "movefocus"; args = "r"; }
    { mod = "SUPER"; keys = "K"; dispatcher = "movefocus"; args = "u"; }
    { mod = "SUPER"; keys = "J"; dispatcher = "movefocus"; args = "d"; }

    { mod = "SUPER SHIFT"; keys = "H"; dispatcher = "swapwindow"; args = "l"; }
    { mod = "SUPER SHIFT"; keys = "L"; dispatcher = "swapwindow"; args = "r"; }
    { mod = "SUPER SHIFT"; keys = "K"; dispatcher = "swapwindow"; args = "u"; }
    { mod = "SUPER SHIFT"; keys = "J"; dispatcher = "swapwindow"; args = "d"; }


    { mod = "SUPER"; keys = "1"; dispatcher = "workspace"; args = "1"; }
    { mod = "SUPER"; keys = "2"; dispatcher = "workspace"; args = "2"; }
    { mod = "SUPER"; keys = "3"; dispatcher = "workspace"; args = "3"; }
    { mod = "SUPER"; keys = "4"; dispatcher = "workspace"; args = "4"; }
    { mod = "SUPER"; keys = "5"; dispatcher = "workspace"; args = "5"; }
    { mod = "SUPER"; keys = "6"; dispatcher = "workspace"; args = "6"; }
    { mod = "SUPER"; keys = "7"; dispatcher = "workspace"; args = "7"; }
    { mod = "SUPER"; keys = "8"; dispatcher = "workspace"; args = "8"; }
    { mod = "SUPER"; keys = "9"; dispatcher = "workspace"; args = "9"; }
    { mod = "SUPER"; keys = "0"; dispatcher = "workspace"; args = "10"; }


    { mod = "SUPER SHIFT"; keys = "1"; dispatcher = "movetoworkspace"; args = "1"; }
    { mod = "SUPER SHIFT"; keys = "2"; dispatcher = "movetoworkspace"; args = "2"; }
    { mod = "SUPER SHIFT"; keys = "3"; dispatcher = "movetoworkspace"; args = "3"; }
    { mod = "SUPER SHIFT"; keys = "4"; dispatcher = "movetoworkspace"; args = "4"; }
    { mod = "SUPER SHIFT"; keys = "5"; dispatcher = "movetoworkspace"; args = "5"; }
    { mod = "SUPER SHIFT"; keys = "6"; dispatcher = "movetoworkspace"; args = "6"; }
    { mod = "SUPER SHIFT"; keys = "7"; dispatcher = "movetoworkspace"; args = "7"; }
    { mod = "SUPER SHIFT"; keys = "8"; dispatcher = "movetoworkspace"; args = "8"; }
    { mod = "SUPER SHIFT"; keys = "9"; dispatcher = "movetoworkspace"; args = "9"; }
    { mod = "SUPER SHIFT"; keys = "0"; dispatcher = "movetoworkspace"; args = "10"; }


    { mod = ""; keys = "XF86AudioRaiseVolume"; dispatcher = "exec"; args = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"; }
    { mod = ""; keys = "XF86AudioLowerVolume"; dispatcher = "exec"; args = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"; }
    { mod = ""; keys = "XF86AudioMute"; dispatcher = "exec"; args = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
    { mod = ""; keys = "XF86AudioMicMute"; dispatcher = "exec"; args = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }
    { mod = ""; keys = "XF86MonBrightnessUp"; dispatcher = "exec"; args = "${pkgs.brightnessctl}/bin/brightnessctl s 10%+"; }
    { mod = ""; keys = "XF86MonBrightnessDown"; dispatcher = "exec"; args = "${pkgs.brightnessctl}/bin/brightnessctl s 10%-"; }
    { mod = ""; keys = "XF86AudioNext"; dispatcher = "exec"; args = "${pkgs.playerctl}/bin/playerctl next"; }
    { mod = ""; keys = "XF86AudioPause"; dispatcher = "exec"; args = "${pkgs.playerctl}/bin/playerctl play-pause"; }
    { mod = ""; keys = "XF86AudioPlay"; dispatcher = "exec"; args = "${pkgs.playerctl}/bin/playerctl play-pause"; }
    { mod = ""; keys = "XF86AudioPrev"; dispatcher = "exec"; args = "${pkgs.playerctl}/bin/playerctl previous"; }
  ];

  exec-once = [
    "waybar"
    "dunst"
    "hyprpaper"
  ];

  exec = [ ];
}
