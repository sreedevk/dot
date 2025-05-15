{
  git = {
    enable-signing = true;
  };

  wallpaper = "wallhaven-p96odm.png";
  desktop = "wayland"; # wayland / x11 / none

  directories = {
    wallpapers = "${builtins.getEnv "HOME"}/Media/wallpapers";
  };
}
