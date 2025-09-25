{
  desktop = {
    enable = true;
    wallpaper = "wallhaven-2ymp5g.png";
    scale = "0.6";
  };

  directories = {
    wallpapers = "${builtins.getEnv "HOME"}/Media/wallpapers";
  };


  git = {
    enable-signing = true;
  };

  username = "sreedev";
}
