{ pkgs, config, lib, ... }:
{
  xdg.mime.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [
        "org.pwmt.zathura.desktop"
        "firefox.desktop"
        "brave-browser.desktop"
      ];
      "application/json" = [
        "firefox.desktop"
        "brave-browser.desktop"
      ];
      "text/plain" = [
        "neovim.desktop"
        "firefox.desktop"
        "brave-browser.desktop"
      ];
      "text/html" = [
        "firefox.desktop"
        "brave-browser.desktop"
        "neovim.desktop"
      ];
      "text/markdown" = [
        "firefox.desktop"
        "brave-browser.desktop"
        "neovim.desktop"
      ];
      "text/unknown" = [
        "neovim.desktop"
        "firefox.desktop"
        "brave-browser.desktop"
      ];
      "inode/directory" = [
        "nemo.desktop"
      ];
      "x-scheme-handler/http" = [
        "firefox.desktop"
        "brave-browser.desktop"
      ];
      "x-scheme-handler/https" = [
        "firefox.desktop"
        "brave-browser.desktop"
      ];
      "x-scheme-handler/about" = [
        "firefox.desktop"
        "brave-browser.desktop"
      ];
      "x-scheme-handler/unknown" = [
        "firefox.desktop"
        "brave-browser.desktop"
      ];
      "image/png" = [
        "nsxiv.desktop"
        "firefox.desktop"
        "brave-browser.desktop"
      ];
      "image/jpeg" = [
        "nsxiv.desktop"
        "firefox.desktop"
        "brave-browser.desktop"
      ];
      "image/gif" = [
        "nsxiv.desktop"
        "firefox.desktop"
        "brave-browser.desktop"
      ];
    };
    associations.added = {
      "application/atom+xml" = [
        "firefox.desktop"
        "brave-browser.desktop"
      ];
    };
  };

  xdg.dataFile."mime/packages/markdown.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
      <mime-type type="text/markdown">
        <comment>Markdown document</comment>
        <glob pattern="*.md"/>
        <glob pattern="*.markdown"/>
      </mime-type>
    </mime-info>
  '';
  home.activation.updateMimeDatabase = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.shared-mime-info}/bin/update-mime-database \
      ${config.xdg.dataHome}/mime
  '';
}
