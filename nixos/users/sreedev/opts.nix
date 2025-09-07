{
  git = {
    enable-signing = true;
  };
  directories = {
    wallpapers = "${builtins.getEnv "HOME"}/Media/wallpapers";
  };
  username = "sreedev";
  desktop = {
    enable = true;
    server = "wayland";
    browser = {
      bin = "firefox";
      xdg-desktop = "firefox.desktop";
    };
    wallpaper = "unsorted/a_road_with_cars_driving_on_it.png";
  };
}
