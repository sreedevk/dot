{
  desktop = {
    enable = true;
    wallpaper = "wallhaven-3q9qky.png";
    scale = "1";
    qt_scale_factor = "1.2";
  };

  directories = 
    let
      homedir  = subpath: "${builtins.getEnv "HOME"}/${subpath}";
      datadir  = subpath: "${builtins.getEnv "HOME"}/Data/${subpath}";
      mediadir = subpath: "${builtins.getEnv "HOME"}/Media/${subpath}";
    in
    {
      data         = homedir "Data";
      documents    = homedir "Documents";
      downloads    = homedir "Downloads";
      finances     = datadir "finances";
      media        = homedir "Media";
      notebook     = datadir "notebook";
      repositories = datadir "repositories";
      resources    = datadir "resources";
      thunderbird  = homedir ".thunderbird";
      wallpapers   = mediadir "wallpapers";
      work         = datadir "work";
    };

  gpg-key-signature = "54E80FA653BDD4DC6700A695B8C402B16E80E17C";

  git = {
    enable-signing = true;
  };

  username = "sreedev";
}
