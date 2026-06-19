{
  desktop = {
    enable = true;
    wallpaper = "wallhaven-3q9qky.png";
    scale = "1";
    qt_scale_factor = "1";
    browser = {
      bin = "brave";
      xdg-desktop = "brave-browser.desktop";
    };
  };

  directories =
    let
      homedir = subpath: "${builtins.getEnv "HOME"}/${subpath}";
      datadir = subpath: "${builtins.getEnv "HOME"}/Data/${subpath}";
      mediadir = subpath: "${builtins.getEnv "HOME"}/Media/${subpath}";
    in
    {
      data = homedir "Data";
      documents = homedir "Documents";
      downloads = homedir "Downloads";
      media = homedir "Media";
      notebook = datadir "notebook";
      repositories = datadir "repositories";
      resources = datadir "resources";
      thunderbird = homedir ".thunderbird";
      wallpapers = mediadir "wallpapers";
    };

  gpg-key-signature = "9F933C72F8137C98E03395427FCFC21B9FE8BD3E";

  git = {
    enable-signing = true;
  };

  username = "srkod";
}
