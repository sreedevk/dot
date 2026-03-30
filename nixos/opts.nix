{

  attic = {
    url = null;
    key = null;
  };

  domains = {
    lan       = { apollo = "external.nullptr.sh"; };
    tailscale = { apollo = "nullptr.sh";          };
  };

  addresses = {
    lan = {
      rpi4b         = "192.168.1.151";
      devtechnica   = "5.161.22.238";
      apollo        = "192.168.1.143";
      rocknix       = "192.168.1.184";
      phonix        = "192.168.1.235";
    };
    tailscale = {
      devtechnica   = "";
      rpi4b         = "100.116.90.85";
      apollo        = "100.110.156.47";
      rocknix       = "100.100.18.78";
      phonix        = "100.96.226.87";
    };
  };

  desktop = {
    browser = {
      bin = "firefox";
      xdg-desktop = "firefox.desktop";
    };
    enable = false;
    wallpaper = null;
    scale = "1";
  };

  monitors = [ ];

  directories = { };

  gpuaccel = null;

  git = {
    enable-signing = false;
  };

  publicKeys = {
    apollo        = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINiYLIEBtoti0D2R5/nuGzXTQaYP7OynXMkAuJBeNit6";
    olivetin      = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIByeKyDW/vNAU29/sBzbyCH1eDTPMPhYDbhAxnNuv1lu";
    rpi4b         = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAul9ZMOMARHw6iSIFbQKChc/bkFBx5/mZnrer/YsRvV";
    terminus      = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKwPdv2zFlfcDbbRvpIYBPh/oRR7MUYjH397Ma+Tu5iB";
    phoenix       = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILECZkgjRGtMkXHr44ytGrfpByPZbP2t5WeF6NgetYIO";
  };

  timeZone = "America/New_York";
  nvidiaVersion = "";
}
