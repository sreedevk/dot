{
  git = {
    enable-signing = false;
  };
  username = "pi";
  directories = { };
  desktop = {
    enable = false;
    server = "wayland";
    browser = {
      bin = "brave";
      xdg-desktop = "brave-browser.desktop";
    };
    wallpaper = "wallhaven-p96odm.png";
  };
}
