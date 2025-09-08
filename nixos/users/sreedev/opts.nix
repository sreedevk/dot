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
    wallpaper = "fauna/a_cartoon_of_a_sea_creature.png";
  };
}
