{
  desktop = {
    enable = true;
    wallpaper = "wallhaven-2ymp5g.png";
    scale = "1";
  };

  directories = {
    wallpapers = "${builtins.getEnv "HOME"}/Media/wallpapers";
  };

  gpuaccel = "rocm";

  git = {
    enable-signing = true;
  };

  username = "sreedev";
}
