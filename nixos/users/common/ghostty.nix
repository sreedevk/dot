{ pkgs, lib, config, ghostty, ... }:
let
  nixglmod = import ./nixGL.nix { inherit lib config pkgs; };
  theme = (import ./themes.nix).zitchdog-pine;
in
{
  programs.ghostty = {
    enable = true;
    clearDefaultKeybinds = true;
    enableZshIntegration = true;
    package = (nixglmod.nixGLWrapped ghostty.default "ghostty");
    themes = {
      zitchdog-pine = {
        background = theme.background;
        cursor-color = theme.cursor;
        foreground = theme.foreground;
        palette = [
          "0=${theme.color0}"
          "1=${theme.color1}"
          "2=${theme.color2}"
          "3=${theme.color3}"
          "4=${theme.color4}"
          "5=${theme.color5}"
          "6=${theme.color6}"
          "7=${theme.color7}"
          "8=${theme.color8}"
          "9=${theme.color9}"
          "10=${theme.color10}"
          "11=${theme.color11}"
          "12=${theme.color12}"
          "13=${theme.color13}"
          "14=${theme.color14}"
          "15=${theme.color15}"
        ];
        selection-background = theme.selection_background;
        selection-foreground = theme.selection_foreground;
      };
    };
    settings = {
      font-family = "Iosevka NF";
      font-size = 14;
      background-opacity = 0.9;
      adjust-underline-position = 6;
      adjust-underline-thickness = 2;
      mouse-hide-while-typing = true;
      theme = "zitchdog-pine";
      window-decoration = false;
      gtk-single-instance = true;
      config-file = "keybindings";
      initial-command = "tmux new -A -s system";
    };
  };

  home.file = {
    ".config/ghostty/keybindings" = {
      enable = true;
      text = ''
        keybind = clear
        keybind = ctrl+shift+r=reload_config
        keybind = ctrl+g=scroll_to_top
        keybind = ctrl+shift+g=scroll_to_bottom
        keybind = ctrl+shift+u=scroll_page_up
        keybind = ctrl+shift+d=scroll_page_down
        keybind = ctrl+shift+space=write_scrollback_file:open
        keybind = ctrl+equal=increase_font_size:1
        keybind = ctrl+minus=decrease_font_size:1
        keybind = ctrl+0=reset_font_size
        keybind = ctrl+alt+u=scroll_page_up
        keybind = ctrl+alt+d=scroll_page_down
        keybind = ctrl+shift+c=copy_to_clipboard
        keybind = ctrl+shift+v=paste_from_clipboard
        keybind = ctrl+shift+t=new_tab
        keybind = ctrl+shift+h=previous_tab
        keybind = ctrl+shift+l=next_tab
      '';
    };
  };
}
