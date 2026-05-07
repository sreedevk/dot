{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ librepods ];
  xdg.desktopEntries = {
    librepods = {
      name = "LibrePods";
      type = "Application";
      exec = "${config.lib.nixGL.wrapOffload pkgs.librepods}/bin/librepods";
      comment = "librepods";
      icon = "librepods";
      terminal = false;
    };
  };
}
