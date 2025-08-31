{ pkgs
, lib
, opts
, ...
}:
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
        experimental = {
          per_monitor_dpi = true;
        };
        global = {
          alignment = "left";
          browser = "${opts.desktop.browser.bin or ""}";
          corner_radius = 5;
          dmenu = "${pkgs.wofi}/bin/wofi --dmenu -p dunst: ";
          enable_recursive_icon_lookup = true;
          follow = "mouse";
          font = lib.mkForce "Iosevka Nerd Font 16";
          force_xinerama = false;
          force_xwayland = false;
          format = "<b>%a</b>\\n%s\\n%b\\n%p";
          frame_color = "#788388";
          frame_width = 0;
          gap_size = 4;
          height = "(0, 150)";
          hide_duplicate_count = false;
          history_length = 10;
          horizontal_padding = 15;
          icon_position = "left";
          idle_threshold = 120;
          ignore_dbusclose = false;
          ignore_newline = "no";
          indicate_hidden = "yes";
          layer = "overlay";
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
          progress_bar_frame_width = 1;
          progress_bar_height = 10;
          progress_bar_max_width = 500;
          progress_bar_min_width = 150;
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
