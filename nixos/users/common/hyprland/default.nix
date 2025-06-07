{ ... }:
{
  imports = [
    ./hyprlock.nix
    ./hyprpaper.nix
    ./waybar.nix
    ./modules
  ];

  # BUG: SCREENSHARING STILL A MESS
  # tried the following options
  # - Followed the guide [here](https://gist.github.com/brunoanc/2dea6ddf6974ba4e5d26c3139ffb7580)
  # - Set the bitdepth for monitors
  # - Using hyprland-git
  # - [Troubleshooting Checklist](https://github.com/emersion/xdg-desktop-portal-wlr/wiki/%22It-doesn't-work%22-Troubleshooting-Checklist)

}
