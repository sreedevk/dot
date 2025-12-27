_: {
  home.file = {
    ".bashrc" = {
      enable = true;
      source = ../../../stowed/.bashrc;
      recursive = true;
    };

    ".bash_profile" = {
      enable = true;
      executable = true;
      recursive = true;
      text = ''
        [[ -f ~/.profile ]]  && . ~/.profile
        [[ -f ~/.bashrc  ]]  && . ~/.bashrc
      '';
    };
  };
}
