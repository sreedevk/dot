{ pkgs
, config
, opts
, ...
}:
let
  wallpaper = "${opts.directories.wallpapers}/${opts.desktop.wallpaper}";
  hyprconf = import ./opts.nix { inherit pkgs config opts; };

  hyprpaperConf = builtins.concatStringsSep "\n" [
    "preload = ${wallpaper}"
    "splash = false"
    "ipc = off"
    (builtins.concatStringsSep "\n" (
      builtins.map (monitor: "wallpaper = desc:${monitor.desc},${wallpaper}") hyprconf.monitors
    ))
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
