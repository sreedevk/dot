{ config, pkgs, ... }:
{
  programs.vicinae = {
    package = config.lib.nixGL.wrapOffload pkgs.vicinae;
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
    };
    extensions = [ ];
    themes = { };
    settings = {
      font.size = 11;
      faviconService = "twenty"; # twenty | google | none
      popToRootOnClose = false;
      rootSearch.searchFiles = false;
      theme.name = "rose-pine";
      launcher_window = {
        client_side_decorations = {
          enabled = true;
          rounding = 10;
          border_width = 1;
        };
        compact_mode = {
          enabled = false;
        };
        screen = "auto";
        dim_around = true;
        layer_shell = {
          enabled = true;
          keyboard_interactivity = "exclusive";
          layer = "top"; # overlay
        };
        csd = true;
        opacity = 0.95;
        keybinds = {
          open-search-filter = "control+P";
          open-settings = "control+,";
          toggle-action-panel = "control+B";
          action.copy = "control+shift+C";
          action.copy-name = "control+shift+.";
          action.copy-path = "control+shift+,";
          action.dangerous-remove = "control+shift+X";
          action.duplicate = "control+D";
          action.edit = "control+E";
          action.edit-secondary = "control+shift+E";
          action.move-down = "control+shift+ARROWDOWN";
          action.move-up = "control+shift+ARROWUP";
          action.new = "control+N";
          action.open = "control+O";
          action.pin = "control+shift+P";
          action.refresh = "control+R";
          action.remove = "control+X";
          action.save = "control+S";
        };
        favorites = [
          "clipboard:history"
        ];
        blur = {
          enabled = true;
        };
        rounding = 10;
      };
    };
  };
}
