{ pkgs, lib, config, ghostty, ... }:
let
  nixglmod = import ./nixGL.nix { inherit lib config pkgs; };
in
{
  home.packages = [
    (nixglmod.nixGLWrapped ghostty.default "ghostty")
  ];

  home.file = {
    ".config/ghostty/themes/zitchdog-grape" = {
      enable = true;
      text = ''
        palette = 0=#0d0910
        palette = 1=#e4374b
        palette = 2=#46cea9
        palette = 3=#e49068
        palette = 4=#65aae3
        palette = 5=#8443e3
        palette = 6=#18c6cd
        palette = 7=#f6ceff
        palette = 8=#2c1e36
        palette = 9=#a22533
        palette = 10=#33857f
        palette = 11=#a25846
        palette = 12=#4568a1
        palette = 13=#5a2ca1
        palette = 14=#6ebad7
        palette = 15=#937b99

        background = #0d0910
        foreground = #8443e3
        cursor-color = #8443e3
        selection-background = #e49068
        selection-foreground = #ffffff
      '';
    };
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
        theme = zitchdog-grape
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
