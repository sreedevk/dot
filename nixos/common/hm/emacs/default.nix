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
        rev = "9c45601ff32076b318731061e18cda8e1cec036c";
      };
    };
  };
}
