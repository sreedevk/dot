{
  desktop = {
    enable = true;
    wallpaper = "wallhaven-2ymp5g.png";
    scale = "0.6";
  };

  directories = {
    wallpapers = "${builtins.getEnv "HOME"}/Media/wallpapers";
  };

  gpuaccel = "cuda";

  git = {
    enable-signing = true;
  };

  username = "sreedev";
}
