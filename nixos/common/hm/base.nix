_: {
  programs = {
    home-manager.enable = true;
  };

  systemd.user = {
    enable = true;
    startServices = "sd-switch";
  };

  news.display = "silent";
}
