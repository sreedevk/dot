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
      telemetry = {
        system_info = false;
      };
      rootSearch.searchFiles = false;
      theme = {
        light = {
          name = "rose-pine";
          icon_theme = "auto";
        };
        dark = {
          name = "rose-pine";
          icon_theme = "auto";
        };
      };
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
          layer = "overlay"; # top
        };
        csd = true;
        opacity = 0.95;
        keybinds = {
          open-search-filter = "control+P";
          open-settings = "control+,";
          toggle-action-panel = "control+B";
          action = {
            copy = "control+shift+C";
            copy-name = "control+shift+.";
            copy-path = "control+shift+,";
            dangerous-remove = "control+shift+X";
            duplicate = "control+D";
            edit = "control+E";
            edit-secondary = "control+shift+E";
            move-down = "control+shift+ARROWDOWN";
            move-up = "control+shift+ARROWUP";
            new = "control+N";
            open = "control+O";
            pin = "control+shift+P";
            refresh = "control+R";
            remove = "control+X";
            save = "control+S";
          };
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
