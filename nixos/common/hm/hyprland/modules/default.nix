{ ... }:
{
  imports = [
    ./animations.nix
    ./cursor.nix
    ./decorations.nix
    ./devices.nix
    ./envs.nix
    ./execs.nix
    ./extra.nix
    ./general.nix
    ./inputs.nix
    ./keybinds.nix
    ./monitors.nix
    ./rules.nix
    ./submaps.nix
  ];

  home.file = {
    ".config/hypr/hyprland.conf" = {
      enable = true;
      text = ''
        source = ~/.config/hypr/monitors.conf
        source = ~/.config/hypr/envs.conf
        source = ~/.config/hypr/keybinds.conf
        source = ~/.config/hypr/execs.conf
        source = ~/.config/hypr/general.conf
        source = ~/.config/hypr/cursor.conf
        source = ~/.config/hypr/decoration.conf
        source = ~/.config/hypr/animations.conf
        source = ~/.config/hypr/inputs.conf
        source = ~/.config/hypr/rules.conf
        source = ~/.config/hypr/extra.conf
        source = ~/.config/hypr/custom_devs.conf
        source = ~/.config/hypr/submaps.conf
        source = ~/.config/hypr/general.conf
        source = ~/.config/hypr/gestures.conf
      '';
    };
  };
}
