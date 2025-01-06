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
        font-size = 14
        background-opacity = 0.9
        adjust-underline-position = 6
        adjust-underline-thickness = 2
        mouse-hide-while-typing = true
        theme = ayu
        window-decoration = false
        # initial-command = tmux new -A -s system

        # Keybindings 
        keybind = clear
        keybind = ctrl+shift+r=reload_config
        keybind = ctrl+g=scroll_to_top
        keybind = ctrl+shift+g=scroll_to_bottom
        keybind = ctrl+shift+u=scroll_page_up
        keybind = ctrl+shift+d=scroll_page_down
        keybind = ctrl+shift+.=write_scrollback_file:paste
        keybind = ctrl+equal=increase_font_size:1
        keybind = ctrl+minus=decrease_font_size:1
        keybind = ctrl+shift+c=copy_to_clipboard
        keybind = ctrl+shift+v=paste_from_clipboard
        keybind = ctrl+shift+t=new_tab
        keybind = ctrl+shift+h=previous_tab
        keybind = ctrl+shift+l=next_tab
      '';
    };
  };
}
