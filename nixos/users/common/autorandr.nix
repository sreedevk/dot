{ pkgs, lib, system, ... }:
let
  monitors = {
    inbuilt = "00ffffffffffff0006af9af900000000141f0104a51e13780363f5a854489d240e505400000001010101010101010101010101010101fa3c80b870b0244010103e002dbc1000001ac83080b870b0244010103e002dbc1000001a000000fe004a38335646804231343055414e0000000000024101b2001100000a410a20200068";
    office = "00ffffffffffff004c2dcb0b41334c30151c0103804728782ad691a7554ea0250c5054bfef80714f810081c081809500a9c0b3000101565e00a0a0a0295030203500c48e2100001a023a801871382d40582c4500c48e2100001e000000fd00184b1b5a19000a202020202020000000fc00533332443835300a2020202020011c02031cf14890041f1303122022230907078301000066030c00100080023a801871382d40582c4500c48e2100001e023a80d072382d40102c4580c48e2100001e011d007251d01e206e285500c48e2100001e011d00bc52d01e20b8285540c48e2100001e000000000000000000000000000000000000000000000000000000a2";
    homelab-0 = "00ffffffffffff001e6d095b783f07000a210104b53c22789e3035a7554ea3260f50542108007140818081c0a9c0d1c08100010101014dd000a0f0703e803020650c58542100001a286800a0f0703e800890650c58542100001a000000fd00383d1e8738000a202020202020000000fc004c4720556c7472612048440a2001d20203117144900403012309070783010000023a801871382d40582c450058542100001e565e00a0a0a029503020350058542100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c8";
    homelab-1 = "00ffffffffffff0060a30914220000001b21010380351e7828ee91a3544c99260f50542dcf00714081c081809500a9c0b300d1c00101023a801871382d40302035000f282100001e000000fc0045532d32345833410a20202020000000ff000a202020202020202020202020000000fd0030641e9020000a2020202020200195020334f4489001020304131f1fe200d5e305c000230907078301000067030c0010001048e6060501626200680000000000000000023a801871382d40302035000f282100001a8e4480a070382d40302035000f282100001a141d56a050002d30302035000f282100001a685b80a070382d40302035000f282100001a000000ee";
  };
in
{

  services.autorandr.enable = true;

  programs.autorandr = {
    enable = true;
    profiles = {
      "undocked" = {
        fingerprint = {
          "undocked-primary" = monitors.inbuilt;
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
          "office-primary" = monitors.office;
          "office-secondary" = monitors.inbuilt;
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
            rate = "60.00";
            dpi = 96;
          };
        };
      };
      "home" = {
        fingerprint = {
          "home-primary" = monitors.homelab-0;
          "home-secondary" = monitors.homelab-1;
          "home-tertiary" = monitors.inbuilt;
        };

        config = {
          "home-secondary" = {
            enable = true;
            crtc = 2;
            primary = false;
            mode = "1920x1080";
            position = "0x0";
            rate = "60.00";
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

