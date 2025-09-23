{
  addresses = {
    lan = {
      nullptrderef1 = "192.168.1.179";
      devstation    = "192.168.1.249";
      rpi4b         = "192.168.1.151";
      devtechnica   = "138.197.225.180";
      apollo        = "192.168.1.141";
    };
    tailscale = {
      nullptrderef1 = "100.117.8.42";
      devstation    = "100.109.36.108";
      rpi4b         = "";
      devtechnica   = "";
      apollo        = "100.95.166.26";
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

  directories = { };
  gpuaccel = null;
  git = {
    enable-signing = false;
  };

  publicKeys = {
    apollo        = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHsoBUqq8XVMmDb5AfOWW4DQC81b1CxqR65KEPSI6Udp";
    devstation    = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIyTIQBuC8gK9HjVViXha1VVTc8mStsrWU1umEM0puuP";
    nullptrderef1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO2pNg6tFrSaQ+oTlGAhboBgQQ+I7S3sXoyM1DfOsI0f";
    olivetin      = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDFulmIlT0R8ghj0ehh5VHSg39CbMNByHEO+3EkKM3zD";
    rpi4b         = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAul9ZMOMARHw6iSIFbQKChc/bkFBx5/mZnrer/YsRvV";
    terminus      = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKwPdv2zFlfcDbbRvpIYBPh/oRR7MUYjH397Ma+Tu5iB";
  };

  timeZone = "America/New_York";
}
