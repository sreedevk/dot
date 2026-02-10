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
        rev = "ecd04f65daacbaef8b9c2f067c1aee8847e5dd39";
      };
    };
  };
}
