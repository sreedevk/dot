{ pkgs, opts, ... }:
{
  programs.gh-dash = {
    enable = true;
    settings = {
      prSections = [{
        title = "My Pull Requests";
        filters = "is:open author:@me";
      }];
    };
  };
  programs.gh = {
    enable = true;
    extensions = [
      "github/gh-actions-importer"
      "meiji163/gh-notify"
      "redraw/gh-install"
      "matt-bartel/gh-clone-org"
      "mislav/gh-cp"
    ];
    settings = {
      github_protocol = "ssh";
      prompt = "enabled";
      aliases = {
        co = "pr checkout";
      };
      editor = "nvim";
      pager = "";
      http_unix_socket = "";
      browser = "${opts.default-web-browser.bin}";
    };
  };
}
