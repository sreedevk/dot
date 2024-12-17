{
  timeZone = "America/New_York";

  default-web-browser = {
    bin = "brave";
    xdg-desktop = "brave-browser.desktop";
  };

  publicKeys = {
    devstation = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIyTIQBuC8gK9HjVViXha1VVTc8mStsrWU1umEM0puuP";
    nullptrderef1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO2pNg6tFrSaQ+oTlGAhboBgQQ+I7S3sXoyM1DfOsI0f";
    terminus = "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBLIIsLk17/QAghVjeIFEd+N1HW/0ucEp92auTlzEU3xMrh46fednqSN3Pa8s7KYnIor4gIDQF4XfOwsmZUj+YgY=";
    olivetin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDFulmIlT0R8ghj0ehh5VHSg39CbMNByHEO+3EkKM3zD";
    rpi4b = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAul9ZMOMARHw6iSIFbQKChc/bkFBx5/mZnrer/YsRvV";
  };

  git = {
    enable-signing = false;
  };
}
