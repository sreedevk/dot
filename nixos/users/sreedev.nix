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
