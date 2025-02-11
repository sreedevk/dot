{ pkgs, config, ... }:
{
  programs.newsboat = {
    enable = true;
    autoReload = false;
    reloadThreads = 8;
    reloadTime = 120;
    browser = "brave";
    maxItems = 30;
    extraConfig = ''
      # ---- OPTS
      always-display-description  true
      cleanup-on-quit             yes
      confirm-exit                yes
      download-full-page          yes
      download-retries            4
      external-url-viewer         "nvim -"
      feed-sort-order             unreadarticlecount-asc
      prepopulate-query-feeds     yes
      save-path                   ~/.local/share/newsboat/saved
      scrolloff                   11
      show-read-feeds             yes
      text-width                  80

      # ---- TITLE FORMATS
      articlelist-title-format    "— [%T]—— (%u unread, %t total)—— %>—— (%U)— "
      datetime-format             "%b %d %H:%M"
      feedlist-title-format       "— [%u feeds with new articles]—— %>—— (%N %V)— "

      # ---- KEYBINDINGS
      bind-key D       pb-download
      bind-key G       end
      bind-key N       prev-unread
      bind-key U       show-urls
      bind-key a       toggle-article-read
      bind-key e       edit-urls
      bind-key d       pagedown
      bind-key f       goto-url
      bind-key g       home
      bind-key j       down
      bind-key k       up
      bind-key n       next-unread
      bind-key o       open-in-browser
      bind-key q       quit
      bind-key u       pageup
      bind-key x       pb-delete
      bind-key s       sort
      bind-key S       rev-sort
      bind-key ;       macro-prefix
      bind-key ^E      edit-flags

      # macros
      macro y set browser "echo %u | xclip -sel clip"; open-in-browser; set browser brave
      macro a set browser mpv; one; set browser brave

      # notification
      notify-format "Newsboat: %f unread feeds (%n unread articles total)"
      notify-program "notify-send"
      notify-always no
      notify-screen no
      notify-xterm yes
      notify-beep no

      # ---- THEME
      color listnormal        cyan default
      color listfocus         black yellow standout bold
      color listnormal_unread blue default
      color listfocus_unread  yellow default bold
      color info              red black bold
      color article           white default bold

      highlight article "(^Feed:.*|^Title:.*|^Author:.*)" cyan default bold
      highlight article "(^Link:.*|^Date:.*)" default default
      highlight article "https?://[^ ]+" green default
      highlight article "^(Title):.*$" blue default
      highlight article "\\[[0-9][0-9]*\\]" magenta default bold
      highlight article "\\[image\\ [0-9]+\\]" green default bold
      highlight article "\\[embedded flash: [0-9][0-9]*\\]" green default bold
      highlight article ":.*\\(link\\)$" cyan default
      highlight article ":.*\\(image\\)$" blue default
      highlight article ":.*\\(embedded flash\\)$" magenta default

      feedlist-format "%?T?║%n %12u %t &╠ %t?"
      highlight feedlist "[║│]" color3 color0
      highlight feedlist "╠.*" color3 color0

      urls-source "miniflux"
      miniflux-url "https://miniflux.nullptr.sh"
      miniflux-login "admin"
      miniflux-passwordeval "${pkgs.coreutils}/bin/cat ${config.age.secrets.miniflux_app_password.path}"
      miniflux-flag-star "s"
    '';
  };
}
