{ pkgs, ... }:
{
  programs.vicinae = {
    package = pkgs.vicinae;
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
    };
    extensions = [ ];
    themes = { };
    settings = {
      font.size = 11;
      favicon_service = "twenty";
      telemetry = {
        system_info = false;
      };
      search_files_in_root = false;
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
        opacity = 1.00;
        favorites = [
          "clipboard:history"
        ];
        blur = {
          enabled = false;
        };
        rounding = 10;
      };
      keybinding = "emacs";
      keybinds = {
        "action.new" = "control+shift+N";
        "open-search-filter" = "control+F";
        "toggle-action-panel" = "control+B";
      };
    };
  };
}
