{ pkgs, config, opts, ... }:
let
  wallpaper = "${opts.directories.wallpapers}/${opts.wallpaper}";
  hyprconf = import ./opts.nix { inherit pkgs config opts; };

  hyprpaperConf =
    builtins.concatStringsSep "\n"
      [
        "preload = ${wallpaper}"
        "splash = false"
        (builtins.concatStringsSep "\n"
          (builtins.map (monitor: "wallpaper = desc:${monitor.desc},${wallpaper}") hyprconf.monitors))
      ];
in
{
  stylix.targets.hyprpaper.enable = true;
  home.file = {
    ".config/hypr/hyprpaper.conf" = {
      enable = true;
      text = hyprpaperConf;
    };
  };
}
