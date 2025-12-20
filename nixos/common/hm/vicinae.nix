{ pkgs, ... }:
{
  home.packages = with pkgs; [ vicinae ];
  services.vicinae = {
    enable = true;
    autoStart = true;
    useLayerShell = true;
    extensions = [ ];
    themes = { };
    settings = {
      font.size = 11;
      faviconService = "twenty"; # twenty | google | none
      popToRootOnClose = false;
      rootSearch.searchFiles = false;
      theme.name = "rose-pine";
      window = {
        csd = true;
        opacity = 0.95;
        rounding = 10;
      };
    };
  };
}
