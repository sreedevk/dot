{ lib
, pkgs
, config
, opts
, ...
}:
let
  defaultWebBrowser = [
    opts.desktop.browser.xdg-desktop
  ];
in
{

  xdg.configFile = {
    "user-dirs.dirs" = {
      enable = true;
      force = true;
      text = ''
        XDG_DESKTOP_DIR="$HOME/Desktop"
        XDG_DOWNLOAD_DIR="$HOME/Downloads"
        XDG_TEMPLATES_DIR="$HOME/"
        XDG_PUBLICSHARE_DIR="$HOME/"
        XDG_DOCUMENTS_DIR="$HOME/Documents"
        XDG_MUSIC_DIR="$HOME/"
        XDG_PICTURES_DIR="$HOME/"
        XDG_VIDEOS_DIR="$HOME/"
      '';
    };
    "user-dirs.locale" = {
      enable = true;
      text = ''
        en_US
      '';
    };
  };

  xdg.mime.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "org.pwmt.zathura.desktop" ] ++ defaultWebBrowser;
      "application/json" = defaultWebBrowser;
      "text/plain" = [ "neovide.desktop" ] ++ defaultWebBrowser;
      "text/html" = defaultWebBrowser ++ [
        "neovide.desktop"
        "neovim.desktop"
      ];
      "text/markdown" = defaultWebBrowser ++ [
        "neovide.desktop"
        "neovim.desktop"
      ];
      "text/unknown" = [
        "neovide.desktop"
        "neovim.desktop"
      ]
      ++ defaultWebBrowser;
      "inode/directory" = [ "nemo.desktop" ];
      "x-scheme-handler/http" = defaultWebBrowser;
      "x-scheme-handler/https" = defaultWebBrowser;
      "x-scheme-handler/about" = defaultWebBrowser;
      "x-scheme-handler/mailto" = [ "org.mozilla.Thunderbird.desktop" ];
      "x-scheme-handler/unknown" = defaultWebBrowser;
      "image/png" = [ "nsxiv.desktop" ] ++ defaultWebBrowser;
      "image/jpeg" = [ "nsxiv.desktop" ] ++ defaultWebBrowser;
      "image/gif" = [ "nsxiv.desktop" ] ++ defaultWebBrowser;
    };
    associations.added = {
      "application/atom+xml" = defaultWebBrowser;
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
