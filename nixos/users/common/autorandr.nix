{ pkgs, secrets, lib, inputs, system, ... }: {
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
            dpi = 96;
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
            dpi = 96;
          };
          "inbuilt" = {
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
            dpi = 96;
          };

          "homelab4k" = {
            enable = true;
            crtc = 0;
            mode = "3840x2160";
            position = "1920x0";
            primary = true;
            rate = "60.00";
            dpi = 96;
            # scale = { method = "factor"; x = 1.2; y = 1.2; };
          };

          "inbuilt" = {
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

