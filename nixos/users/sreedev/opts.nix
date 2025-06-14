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
      bin = "brave";
      xdg-desktop = "brave-browser.desktop";
    };
    wallpaper = "wallhaven-p96odm.png";
  };
}
