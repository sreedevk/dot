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

  services.emacs = {
    enable = true;
    startWithUserSession = "graphical";
    client.enable = true;
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
        rev = "b3a119823faced6c5768bb9d749dd57d300cacb5";
        ref = "master";
      };
    };
  };
}
