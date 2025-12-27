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
          keyword = "np";
        }
        {
          name = "Bookmarks";
          url = "https://kk.nullptr.sh";
          keyword = "kk";
        }
        {
          name = "HackerNews";
          url = "https://news.ycombinator.com/";
          keyword = "hn";
        }
        {
          name = "Lobsters";
          url = "https://lobste.rs/";
          keyword = "lb";
        }
        {
          name = "Excalidraw";
          url = "https://excalidraw.com/";
          keyword = "ex";
        }
        {
          name = "Other";
          toolbar = false;
          bookmarks = [
            {
              name = "Flix";
              url = "https://sflix.fi/home";
            }
          ];
        }
      ];
    }
  ];
}
