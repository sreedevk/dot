{ pkgs, config, ... }:
{

  home.packages =
    with pkgs; [
      ladybird
    ];


  xdg.desktopEntries = {
    ladybird = {
      name = "Ladybird";
      genericName = "Browser";
      exec = "Ladybird";
      icon = "Ladybird";
      terminal = false;
      categories = [ "Network" "WebBrowser" ];
    };
  };
}
