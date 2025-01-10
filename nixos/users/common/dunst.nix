{ pkgs, lib, opts, ... }:
let
  dunstctl = pkgs.writeShellScriptBin "dunstctl" ''
    DISPLAY=:0 ${pkgs.dunst}/bin/dunstctl $@
  '';
in
{
  home.packages = [ dunstctl ];
  services = {
    dunst = {
      enable = true;
      package = pkgs.writeShellScriptBin "dunst" ''
        DISPLAY=:0 ${pkgs.dunst}/bin/dunst
      '';
      iconTheme = {
        package = pkgs.rose-pine-icon-theme;
        name = "rose-pine";
      };
      settings = {
        global = {
          alignment = "left";
          browser = "${opts.default-web-browser.bin}";
          corner_radius = 5;
          dmenu = "${pkgs.wofi}/bin/wofi --dmenu -p dunst: ";
          enable_recursive_icon_lookup = true;
          follow = "mouse";
          font = lib.mkForce "Iosevka NF 16";
          format = "<b>%a</b>\\n%s\\n%b\\n%p";
          frame_color = "#788388";
          frame_width = 0;
          gap_size = 4;
          height = "(0, 150)";
          hide_duplicate_count = true;
          history_length = 10;
          horizontal_padding = 15;
          icon_position = "off";
          idle_threshold = 120;
          ignore_newline = "no";
          indicate_hidden = "yes";
          line_height = 1;
          markup = "yes";
          monitor = 0;
          mouse_left_click = "open_url, do_action, close_current";
          mouse_middle_click = "close_all";
          mouse_right_click = "close_current";
          offset = 20;
          origin = "top-right";
          padding = 15;
          progress_bar = true;
          show_age_threshold = 60;
          show_indicators = "yes";
          shrink = "yes";
          sort = "yes";
          stack_duplicates = true;
          sticky_history = "yes";
          transparency = 30;
          width = 500;
          word_wrap = "yes";
        };
        urgency_low = {
          background = lib.mkDefault "#263238";
          foreground = lib.mkDefault "#556064";
          timeout = 10;
        };

        urgency_normal = {
          background = lib.mkForce "#0d0910";
          foreground = lib.mkForce "#8443e3";
          timeout = 10;
        };

        urgency_critical = {
          background = lib.mkDefault "#a22533";
          foreground = lib.mkDefault "#e0def4";
          timeout = 0;
        };
      };
    };
  };
}
