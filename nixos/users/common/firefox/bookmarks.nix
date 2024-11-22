[
  {
    name = "main";
    toolbar = true;
    bookmarks = [
      {
        name = "Subscribe (miniflux)";
        url = "javascript:location.href='https://miniflux.nullptr.sh/bookmarklet?uri='+encodeURIComponent(window.location.href)";
      }
      {
        name = "Bookmark (Linkding)";
        url = ''
          javascript: (function () {
            var bookmarkUrl = window.location;
            var applicationUrl = 'https://links.nullptr.sh/bookmarks/new';
            applicationUrl += '?url=' + encodeURIComponent(bookmarkUrl);
            applicationUrl += '&auto_close';
            window.open(applicationUrl);
          })();
        '';
      }
      {
        name = "nullptr.sh";
        url = "https://nullptr.sh";
      }
      {
        name = "bookmarks";
        url = "https://links.nullptr.sh";
      }
      {
        name = "hackernews";
        url = "https://news.ycombinator.com/";
      }
      {
        name = "lobsters";
        url = "https://lobste.rs/";
      }
      {
        name = "Excalidraw";
        url = "https://excalidraw.com/";
      }
      {
        name = "ProtonDrive";
        url = "https://drive.proton.me";
      }
      {
        name = "ProtonMail";
        url = "https://mail.proton.me";
      }
    ];
  }
]
