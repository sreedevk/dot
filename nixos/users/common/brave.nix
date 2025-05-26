{ pkgs, lib, config, ... }:
let
  nixglmod = import ./nixGL.nix { inherit lib config pkgs; };
  nixgl-brave-pkg = (nixglmod.nixGLWrapped pkgs.brave "brave");
in
{
  home.packages = [ nixgl-brave-pkg ];
  xdg.desktopEntries = {
    brave-browser = {
      name = "Brave";
      icon = "brave-desktop";
      genericName = "Web Browser";
      exec = "env __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia ${nixgl-brave-pkg}/bin/brave %U";
      comment = "Access the Internet";
      mimeType = [
        "application/pdf"
        "application/rdf+xml"
        "application/rss+xml"
        "application/xhtml+xml"
        "application/xhtml_xml"
        "application/xml"
        "image/gif"
        "image/jpeg"
        "image/png"
        "image/webp"
        "text/html"
        "text/xml"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
        "x-scheme-handler/ipfs"
        "x-scheme-handler/ipns"
      ];
      terminal = false;
      type = "Application";
      categories = [ "Network" "WebBrowser" ];
    };
  };
}
