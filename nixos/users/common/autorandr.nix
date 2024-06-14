{ pkgs, secrets, lib, inputs, system, ... }: {
  programs.autorandr = {
    enable = true;
    profiles = {
      "undocked" = {
        fingerprint = {
          "undocked-primary" = secrets.autorandr.monitors.inbuilt;
        };
        config = {
          "undocked-primary" = {
            enable = true;
            crtc = 0;
            primary = true;
            mode = "1920x1200";
            position = "0x0";
            rate = "60.03";
            dpi = 96;
          };
        };
      };
      "office" = {
        fingerprint = {
          "office-primary" = secrets.autorandr.monitors.office;
          "office-secondary" = secrets.autorandr.monitors.inbuilt;
        };
        config = {
          "office-primary" = {
            enable = true;
            crtc = 1;
            primary = false;
            mode = "2560x1440";
            position = "1920x0";
            rate = "59.95";
            dpi = 96;
          };
          "office-secondary" = {
            enable = true;
            crtc = 0;
            primary = true;
            mode = "1920x1200";
            position = "0x0";
            rate = "60.03";
            dpi = 96;
          };
        };
      };
      "home" = {
        fingerprint = {
          "home-primary" = secrets.autorandr.monitors.homelab4k;
          "home-secondary" = secrets.autorandr.monitors.homelab1080p;
          "home-tertiary" = secrets.autorandr.monitors.inbuilt;
        };

        config = {
          "home-secondary" = {
            enable = true;
            crtc = 2;
            primary = false;
            mode = "1920x1080";
            position = "0x0";
            rate = "100.00";
            dpi = 96;
          };

          "home-primary" = {
            enable = true;
            crtc = 0;
            mode = "3840x2160";
            position = "1920x0";
            primary = true;
            rate = "60.00";
            dpi = 96;
            # scale = { method = "factor"; x = 1.2; y = 1.2; };
          };

          "home-tertiary" = {
            enable = true;
            crtc = 1;
            mode = "1920x1200";
            position = "0x1080";
            primary = false;
            rate = "60.03";
            dpi = 96;
          };
        };
      };
    };
  };
}

