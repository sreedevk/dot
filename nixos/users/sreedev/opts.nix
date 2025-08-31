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
    wallpaper = "apocalypse/a_street_with_a_bridge_and_people_sitting_on_it.jpg";
  };
}
