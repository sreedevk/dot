{
  desktop = {
    enable = true;
    wallpaper = "flowers/a_group_of_pink_flowers_on_a_tree.jpg";
    scale = "1";
  };

  directories = {
    wallpapers = "${builtins.getEnv "HOME"}/Media/wallpapers";
  };


  git = {
    enable-signing = true;
  };

  username = "sreedev";
}
