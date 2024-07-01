{ pkgs, lib, inputs, system, ... }: {
  services = {
    dunst = {
      enable = true;
      iconTheme = {
        package = pkgs.rose-pine-icon-theme;
        name = "rose-pine";
      };
      settings = {
        global = {
          alignment = "left";
          allow_markup = "yes";
          bounce_freq = 0;
          browser = "brave";
          corner_radius = 5;
          dmenu = "/usr/bin/dmenu - p dunst: ";
          enable_recursive_icon_lookup = true;
          follow = "mouse";
          font = lib.mkDefault "Iosevka NF 16";
          format = "%a\\n<b>%s</b>\\n%b\\n%p";
          frame_color = "#788388";
          frame_width = 0;
          gap_size = 4;
          height = 150;
          hide_duplicate_count = true;
          history_length = 10;
          horizontal_padding = 8;
          icon_position = "left";
          idle_threshold = 120;
          ignore_newline = "no";
          indicate_hidden = "yes";
          line_height = 1;
          markup = "yes";
          monitor = 0;
          mouse_left_click = "open_url, do_action, close_current";
          mouse_middle_click = "close_all";
          mouse_right_click = "close_current";
          notification_height = 0;
          offset = 20;
          origin = "top-right";
          padding = 12;
          progress_bar = true;
          show_age_threshold = 60;
          show_indicators = "yes";
          shrink = "yes";
          sort = "yes";
          stack_duplicates = true;
          startup_notification = false;
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
          background = lib.mkDefault "#263238";
          foreground = lib.mkDefault "#F9FAF9";
          timeout = 10;
        };

        urgency_critical = {
          background = lib.mkDefault "#D62929";
          foreground = lib.mkDefault "#F9FAF9";
          timeout = 0;
        };
      };
    };
  };
}
