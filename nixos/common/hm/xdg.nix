{ lib
, pkgs
, config
, ...
}:
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
        "neovide.desktop"
        "firefox.desktop"
        "brave-browser.desktop"
      ];
      "text/html" = [
        "firefox.desktop"
        "brave-browser.desktop"
        "neovide.desktop"
        "neovim.desktop"
      ];
      "text/markdown" = [
        "brave-browser.desktop"
        "firefox.desktop"
        "neovide.desktop"
        "neovim.desktop"
      ];
      "text/unknown" = [
        "neovide.desktop"
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
      "x-scheme-handler/mailto" = [
        "org.mozilla.Thunderbird.desktop"
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

  home.file.".local/share/mime/packages/text-markdown.xml" = {
    text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
        <mime-type type="text/markdown">
          <comment>Markdown document</comment>
          <glob pattern="*.md"/>
          <glob pattern="*.markdown"/>
          <glob pattern="*.mkd"/>
          <glob pattern="*.mkdn"/>
          <glob pattern="*.mdwn"/>
          <glob pattern="*.mdown"/>
          <glob pattern="*.markdown"/>
        </mime-type>
      </mime-info>
    '';
  };

  home.activation.updateMimeDatabase = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.shared-mime-info}/bin/update-mime-database \
      ${config.home.homeDirectory}/.local/share/mime
  '';
}
