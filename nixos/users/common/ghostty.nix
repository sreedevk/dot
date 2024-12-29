{ pkgs, lib, config, ghostty, ... }:
let
  nixglmod = import ./nixGL.nix { inherit lib config pkgs; };
in
{
  home.packages = [
    (nixglmod.nixGLWrapped ghostty.default "ghostty")
  ];

  home.file = {
    ".config/ghostty/config" = {
      enable = true;
      text = ''
        # Appearance
        font-family = Iosevka Nerd Font
        font-size = 16
        background-opacity = 0.9
        theme = Floraverse
        window-decoration = false
        # initial-command = tmux new -A -s system

        # Keybindings 
        keybind = ctrl+a>t=new_tab
        keybind = ctrl+a>g=scroll_to_top
        keybind = ctrl+a>shift+g=scroll_to_bottom
        keybind = ctrl+a>.=write_scrollback_file:open
      '';
    };
  };
}
