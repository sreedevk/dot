{ pkgs, ... }:
{
  services.clamav = {
    daemon = {
      enable = true;
      settings = { };
    };

    scanner = {
      enable = true;
      interval = "daily";
      scanDirectories = [
        "/mnt/dpool1/appdata/files"
      ];
    };

    updater = {
      enable = true;
      interval = "weekly";
      frequency = 12;
      settings = { };
    };

  };
}
