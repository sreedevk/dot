{ pkgs, ... }:
{
  home.file = {
    ".config/supervisor/programs/radnode.ini" = {
      enable = true;
      text = ''
        [program:radnode] 
        command=${pkgs.radicle-node}/bin/rad node start --foreground
        autostart=false
      '';
    };
  };
}
