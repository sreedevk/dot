{ ... }:
{
  imports = [
    ./hyprlock.nix
    ./modules
    ./uwsm.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      source = [
        "~/.config/hypr/monitors.conf"
        "~/.config/hypr/envs.conf"
        "~/.config/hypr/keybinds.conf"
        "~/.config/hypr/execs.conf"
        "~/.config/hypr/general.conf"
        "~/.config/hypr/cursor.conf"
        "~/.config/hypr/decoration.conf"
        "~/.config/hypr/animations.conf"
        "~/.config/hypr/inputs.conf"
        "~/.config/hypr/rules.conf"
        "~/.config/hypr/extra.conf"
        "~/.config/hypr/custom_devs.conf"
        "~/.config/hypr/submaps.conf"
        "~/.config/hypr/general.conf"
        "~/.config/hypr/gestures.conf"
        "~/.config/hypr/plugins.conf"
      ];
    };
  };
}
