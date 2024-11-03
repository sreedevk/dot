{ pkgs, config, opts, ... }:
let
  walldir = "~/Media/wallpapers";
  wallpaper = "${walldir}/park.jpg";
  hyprconf = import ./hyprland/opts.nix { inherit pkgs config opts; };

  hyprpaperConf =
    builtins.concatStringsSep "\n"
      [
        "preload = ${wallpaper}"
        "splash = true"
        (builtins.concatStringsSep "\n"
          (builtins.map (monitor: "wallpaper = desc:${monitor.desc},${wallpaper}") hyprconf.monitors))
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
