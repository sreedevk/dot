{ pkgs, ... }:
{
  programs.zathura = {
    enable = true;
    extraConfig = ''
      map <C-=> zoom in
      map <C--> zoom out
      set selection-clipboard clipboard
    '';
  };
}
