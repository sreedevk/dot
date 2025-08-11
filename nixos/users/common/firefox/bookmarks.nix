{
  force = true;
  settings = [
    {
      name = "main";
      toolbar = true;
      bookmarks = [
        {
          name = "Subscribe (miniflux)";
          url = "javascript:location.href='https://miniflux.nullptr.sh/bookmarklet?uri='+encodeURIComponent(window.location.href)";
        }
        {
          name = "nullptr.sh";
          url = "https://nullptr.sh";
        }
        {
          name = "bookmarks";
          url = "https://hoarder.nullptr.sh";
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
      ];
    }
  ];
}
