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
      exec = "env __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia ${config.lib.nixGL.wrapOffload pkgs.librepods}/bin/librepods";
      comment = "librepods";
      icon = "librepods";
      terminal = false;
    };
  };
}
