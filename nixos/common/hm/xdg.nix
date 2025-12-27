{ opts, ... }:
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf"          = [ "org.pwmt.zathura.desktop" ];
      "text/plain"               = [ "neovim.desktop" ];
      "text/html"                = [ "neovim.desktop" ];
      "text/unknown"             = [ "neovim.desktop" ];
      "inode/directory"          = [ "nemo.desktop" ];
      "x-scheme-handler/http"    = opts.desktop.browser.xdg-desktop or "";
      "x-scheme-handler/https"   = opts.desktop.browser.xdg-desktop or "";
      "x-scheme-handler/about"   = opts.desktop.browser.xdg-desktop or "";
      "x-scheme-handler/unknown" = opts.desktop.browser.xdg-desktop or "";
      "image/png"                = "nsxiv.desktop";
      "image/jpeg"               = "nsxiv.desktop";
      "image/gif"                = "nsxiv.desktop";
    };
    associations.added = {
      "application/atom+xml" = opts.desktop.browser.xdg-desktop or "";
    };
  };
}
