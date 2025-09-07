{ ... }:
{
  home.file = {
    ".config/ghostty/config" = {
      enable = true;
      text = ''
        background-blur = 30
        background-opacity = 0.9
        config-file = keybindings
        font-family = "IosevkaTerm Nerd Font"
        font-size = 14
        gtk-single-instance = true
        initial-command = "tmux new -A -s system"
        mouse-hide-while-typing = true
        shell-integration = none
        theme = Nocturnal Winter
        window-decoration = false
      '';
    };
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
        keybind = ctrl+shift+c=copy_to_clipboard
        keybind = ctrl+shift+v=paste_from_clipboard
        keybind = ctrl+shift+t=new_tab
        keybind = ctrl+shift+h=previous_tab
        keybind = ctrl+shift+l=next_tab
      '';
    };
  };
}
