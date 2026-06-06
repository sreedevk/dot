{ pkgs, ... }:
{
  home.packages = [ pkgs.brave ];
  xdg.desktopEntries = {
    brave-browser = {
      name = "Brave";
      icon = "brave-browser";
      genericName = "Web Browser";
      exec = "${pkgs.brave}/bin/brave %U";
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
      categories = [
        "Network"
        "WebBrowser"
      ];
    };
  };
}
