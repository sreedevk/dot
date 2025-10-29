{
  desktop = {
    enable = true;
    wallpaper = "wallhaven-3q9qky.png";
    scale = "1";
  };

  directories = {
    wallpapers = "${builtins.getEnv "HOME"}/Media/wallpapers";
  };


  git = {
    enable-signing = true;
  };

  username = "sreedev";
}
