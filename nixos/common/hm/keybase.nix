{ pkgs
, config
, ...
}:
{

  home.packages = with pkgs; [
    keybase
    (config.lib.nixGL.wrap pkgs.keybase-gui)
  ];

  services.keybase.enable = true;
  services.kbfs.enable = true;

}
