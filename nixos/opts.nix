{
  addresses = {
    lan = {
      devstation    = "192.168.1.249";
      rpi4b         = "192.168.1.151";
      devtechnica   = "5.161.22.238";
      apollo        = "192.168.1.143";
      rocknix       = "";
    };
    tailscale = {
      devstation    = "100.109.36.108";
      devtechnica   = "";
      rpi4b         = "";
      apollo        = "100.121.45.124";
      rocknix       = "100.100.18.78";
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
    devstation    = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIyTIQBuC8gK9HjVViXha1VVTc8mStsrWU1umEM0puuP";
    olivetin      = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIByeKyDW/vNAU29/sBzbyCH1eDTPMPhYDbhAxnNuv1lu";
    rpi4b         = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAul9ZMOMARHw6iSIFbQKChc/bkFBx5/mZnrer/YsRvV";
    terminus      = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKwPdv2zFlfcDbbRvpIYBPh/oRR7MUYjH397Ma+Tu5iB";
  };

  timeZone = "America/New_York";
  nvidiaVersion = "";
}
