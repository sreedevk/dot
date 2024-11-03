{ pkgs, config, opts, ... }:
let
  walldir = "~/Media/wallpapers";
  wallpaper = "${walldir}/park.jpg";
  hyprpaperConf =
    builtins.concatStringsSep
      "\n"
      [
        "preload = ${wallpaper}"
        "splash = true"
        (builtins.map
          (monitor: "wallpaper = desc:${monitor.desc},${wallpaper}")
          opts.hyprland.monitors)
      ];
in
{
  home.file = {
    ".config/hypr/hyprpaper.conf" = {
      enable = true;
      text = hyprpaperConf;
    };
  };
}
