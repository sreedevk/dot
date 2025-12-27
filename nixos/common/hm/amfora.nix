{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    amfora # gemini protocol browser
  ];

  xdg.desktopEntries = {
    amfora = {
      name = "Amfora";
      icon = "amfora";
      genericName = "Gemini TUI Browser";
      exec = "${config.programs.alacritty.package}/bin/alacritty -e ${pkgs.amfora}/bin/amfora %u";
      comment = "Browse Gemini in the terminal.";
      mimeType = [ "x-scheme-handler/gemini" ];
      terminal = false;
      categories = [
        "Network"
        "WebBrowser"
        "ConsoleOnly"
      ];
      type = "Application";
      settings = {
        Keywords = "gemini";
      };
    };
  };

  home.file = {
    ".config/amfora/config.toml" = {
      source = (pkgs.formats.toml { }).generate "amforaconf" {
        a-general = {
          home = "gemini://geminiprotocol.net";
          auto_redirect = true;
          http = [ "${config.programs.firefox.package}/bin/firefox" ];
          search = "gemini://geminispace.info/search";
          color = true;
          ansi = true;
          highlight_code = true;
          highlight_style = "monokai";
          bullets = true;
          show_link = false;
          max_width = 80;
          downloads = "${builtins.getEnv "HOME"}/Downloads";
          underline = true;
          scrollbar = "auto";
          page_max_time = 10;
        };
        auth = {
          certs = { };
          keys = { };
        };
        keybindings = { };
        url-handlers = {
          other = "default";
        };
        url-prompts = { };
        cache = {
          max_size = 0;
          max_pages = 30;
          timeout = 1800;
        };
        proxies = { };
        subscriptions = {
          popup = true;
          update_interval = 1800;
          workers = 3;
          entries_per_page = 20;
          header = true;
        };
        theme = { };
      };
    };
  };
}
