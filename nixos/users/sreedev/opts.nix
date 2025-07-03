{
  git = { enable-signing = true; };
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
    wallpaper = "wallhaven-3q9qky.png";
  };
}
