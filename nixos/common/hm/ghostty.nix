{ pkgs, config, ... }:
{
  programs.ghostty = {
    enable = true;
    package = config.lib.nixGL.wrapOffload pkgs.ghostty;
    clearDefaultKeybinds = true;
    settings = {
      background-blur = 30;
      background-opacity = 0.9;
      font-family = "IosevkaTerm Nerd Font";
      font-size = 14;
      gtk-single-instance = true;
      initial-command = "tmux new -A -s system";
      mouse-hide-while-typing = true;
      shell-integration = "none";
      window-decoration = false;
      keybind = [
        "ctrl+shift+r=reload_config"
        "ctrl+g=scroll_to_top"
        "ctrl+shift+g=scroll_to_bottom"
        "ctrl+shift+u=scroll_page_up"
        "ctrl+shift+d=scroll_page_down"
        "ctrl+shift+space=write_scrollback_file:open"
        "ctrl+equal=increase_font_size:1"
        "ctrl+minus=decrease_font_size:1"
        "ctrl+shift+c=copy_to_clipboard"
        "ctrl+shift+v=paste_from_clipboard"
        "ctrl+shift+t=new_tab"
        "ctrl+shift+h=previous_tab"
        "ctrl+shift+l=next_tab"
      ];
    };
  };
}
