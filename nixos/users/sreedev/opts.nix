{
  git = { enable-signing = true; };
  directories = {
    wallpapers = "${builtins.getEnv "HOME"}/Media/wallpapers";
  };
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
