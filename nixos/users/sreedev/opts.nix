{
  desktop = {
    enable = true;
    wallpaper = "wallhaven-2ymp5g.png";
  };

  directories = {
    wallpapers = "${builtins.getEnv "HOME"}/Media/wallpapers";
  };

  git = {
    enable-signing = true;
  };

  username = "sreedev";
}
