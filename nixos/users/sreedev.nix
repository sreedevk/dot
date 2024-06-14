{ pkgs, secrets, lib, ... }: {
  imports = [ ./shared ];
  home = {
    username = "sreedev";
    homeDirectory = "/home/sreedev";
    stateVersion = "23.11";
    packages = with pkgs; [
      autorandr
      autotiling
      awscli2
      dunst
      emacs
      floorp
      jira-cli-go
      (nerdfonts.override { fonts = [ "Iosevka" ]; })
    ];
  };

  fonts.fontconfig = {
    enable = lib.mkForce true;
    defaultFonts = {
      monospace = [ "Iosevka NF" ];
      serif = [ "Iosevka NF" ];
      sansSerif = [ "Iosevka NF" ];
    };
  };

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
          font = "Iosevka NF 12";
          format = "%a\n<b>%s</b>\n%b\n%p";
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
          padding = 8;
          progress_bar = true;
          show_age_threshold = 60;
          show_indicators = "yes";
          shrink = "yes";
          sort = "yes";
          stack_duplicates = true;
          startup_notification = false;
          sticky_history = "yes";
          transparency = 30;
          width = 450;
          word_wrap = "yes";
        };
        urgency_low = {
          background = "#263238";
          foreground = "#556064";
          timeout = 10;
        };

        urgency_normal = {
          background = "#263238";
          foreground = "#F9FAF9";
          timeout = 10;
        };

        urgency_critical = {
          background = "#D62929";
          foreground = "#F9FAF9";
          timeout = 0;
        };
      };
    };
  };

  systemd.user.services = {
    autotiling = {
      Unit = {
        Description = "xorg based window manager autotiling service";
        Documentation = "https://github.com/nwg-piotr/autotiling";
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.autotiling}/bin/autotiling";
        Restart = "always";
        RestartSec = 3;
        StartLimitInterval = 0;
        StartLimitBurst = 0;
      };
      Install = { WantedBy = [ "default.target" ]; };
    };
  };

  programs.awscli = {
    enable = true;
    settings = {
      "default" = {
        region = secrets.aws.config.region;
        output = "json";
      };
    };
    credentials = {
      "default" = {
        "aws_access_key_id" = secrets.aws.credentials.aws_access_key_id;
        "aws_secret_access_key" = secrets.aws.credentials.aws_secret_access_key;
      };
    };
  };

  programs.autorandr = {
    enable = true;
    profiles = {
      "undocked" = {
        fingerprint = {
          "inbuilt" = secrets.autorandr.monitors.inbuilt;
        };
        config = {
          "inbuilt" = {
            enable = true;
            crtc = 0;
            primary = true;
            mode = "1920x1200";
            position = "0x0";
            rate = "60.03";
          };
        };
      };
      "office" = {
        fingerprint = {
          "officemonitor" = secrets.autorandr.monitors.office;
          "inbuilt" = secrets.autorandr.monitors.inbuilt;
        };
        config = {
          "officemonitor" = {
            enable = true;
            crtc = 1;
            primary = false;
            mode = "2560x1440";
            position = "1920x0";
            rate = "59.95";
          };
          "inbuilt" = {
            enable = true;
            crtc = 0;
            primary = true;
            mode = "1920x1200";
            position = "0x0";
            rate = "60.03";
          };
        };
      };
      "home" = {
        fingerprint = {
          "homelab4k" = secrets.autorandr.monitors.homelab4k;
          "homelab1080p" = secrets.autorandr.monitors.homelab1080p;
          "inbuilt" = secrets.autorandr.monitors.inbuilt;
        };

        config = {
          "homelab1080p" = {
            enable = true;
            crtc = 2;
            primary = false;
            mode = "1920x1080";
            position = "0x0";
            rate = "100.00";
          };

          "homelab4k" = {
            enable = true;
            crtc = 0;
            mode = "3840x2160";
            position = "1920x0";
            primary = true;
            rate = "60.00";
          };

          "inbuilt" = {
            enable = true;
            crtc = 1;
            mode = "1920x1200";
            position = "0x1080";
            primary = false;
            rate = "60.03";
          };
        };
      };
    };
  };

  programs.zsh.enable = true;
}
