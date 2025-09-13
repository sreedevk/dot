{
  desktop = {
    enable = true;
    wallpaper = "fauna/a_cartoon_of_a_sea_creature.png";
  };

  directories = {
    wallpapers = "${builtins.getEnv "HOME"}/Media/wallpapers";
  };

  git = {
    enable-signing = true;
  };

  username = "sreedev";
}
