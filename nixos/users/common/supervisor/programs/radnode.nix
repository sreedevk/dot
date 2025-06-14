{ pkgs, ... }:
{
  home.file = {
    ".config/supervisor/programs/radnode.ini" = {
      enable = true;
      text = ''
        [program:radnode] 
        command=${pkgs.radicle-node}/bin/radicle-node --foreground
        autostart=false
      '';
    };
  };
}
