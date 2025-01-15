{
  git = {
    enable-signing = true;
  };

  wallpaper = "wallhaven-d61kgg.jpg";
  desktop = "wayland"; # wayland / x11 / none

  directories = {
    wallpapers = "${builtins.getEnv "HOME"}/Media/wallpapers";
  };
}
