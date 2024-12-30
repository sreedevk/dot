{ ... }:
{

  stylix.targets.zathura.enable = true;

  programs.zathura = {
    enable = true;
    extraConfig = ''
      map <C-=> zoom in
      map <C--> zoom out
      map <C-h> rotate rotate-ccw
      map <C-l> rotate rotate-cw
      set selection-clipboard clipboard
    '';
  };
}
