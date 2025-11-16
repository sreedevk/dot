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


  git = {
    enable-signing = true;
  };

  username = "sreedev";
}
