{ pkgs, ... }:
let
  hypr-launch-script = pkgs.writeShellScriptBin "hyprlaunch" ''
    if uwsm check may-start && uwsm select; then
      exec uwsm start default
    fi
  '';
in
{
  imports = [
    ./hyprlock.nix
    ./modules
    ./waybar.nix
  ];

  home.packages = [ hypr-launch-script ];

  # BUG: SCREENSHARING STILL A MESS
  # tried the following options
  # - Followed the guide [here](https://gist.github.com/brunoanc/2dea6ddf6974ba4e5d26c3139ffb7580)
  # - Set the bitdepth for monitors
  # - Using hyprland-git
  # - [Troubleshooting Checklist](https://github.com/emersion/xdg-desktop-portal-wlr/wiki/%22It-doesn't-work%22-Troubleshooting-Checklist)

}
