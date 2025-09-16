{
  config,
  pkgs,
  ...
}:
{
  home.sessionVariables = {
    DOOMDIR = "${config.xdg.configHome}/doom";
    EMACSDIR = "${config.xdg.configHome}/emacs";
    DOOMLOCALDIR = "${config.xdg.dataHome}/doom";
    DOOMPROFILELOADFILE = "${config.xdg.stateHome}/doom-profiles-load.el";
  };

  home.sessionPath = [ "${config.xdg.configHome}/emacs/bin" ];
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  xdg.configFile = {

    doom = {
      enable = true;
      source = ./doom;
      recursive = true;
    };

    emacs = {
      enable = true;
      source = builtins.fetchGit {
        url = "https://github.com/doomemacs/doomemacs.git";
        rev = "e10477d6d1f1cd8c9369daad6b74f7d2e6e9fad9";
      };
    };
  };
}
