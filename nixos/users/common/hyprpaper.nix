{ pkgs, config, opts, ... }:
{
  home.file = {
    ".config/hypr/hyprpaper.conf" = {
      enable = true;
      text = ''
        preload = ~/Media/wallpapers/foresty-beach.jpg
        preload = ~/Media/wallpapers/japanese-building.png
        preload = ~/Media/wallpapers/grass.jpg
        wallpaper = DP-2,~/Media/wallpapers/foresty-beach.jpg
        wallpaper = DP-3,~/Media/wallpapers/japanese-building.png
        wallpaper = eDP-1,~/Media/wallpapers/grass.jpg
        splash = true
        # ipc = off
      '';
    };
  };
}
