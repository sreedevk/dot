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
    extensions = with pkgs; [
      gh-notify
      gh-cal
      gh-markdown-preview
      gh-s
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
      browser = "${opts.desktop.browser.bin or ""}";
    };
  };
}
