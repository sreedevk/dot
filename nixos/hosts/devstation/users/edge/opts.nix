{
  desktop = {
    enable = true;
    wallpaper = "wallhaven-3q9qky.png";
    scale = "1";
    qt_scale_factor = "1.2";
  };

  directories = {
    wallpapers = "${builtins.getEnv "HOME"}/Media/wallpapers";
  };

  gpg-key-signature = "54E80FA653BDD4DC6700A695B8C402B16E80E17C";

  git = {
    enable-signing = true;
  };

  username = "sreedev";
}
