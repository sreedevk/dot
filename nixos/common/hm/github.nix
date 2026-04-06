{
  pkgs,
  opts,
  config,
  ...
}:
{

  systemd.user.sessionVariables = {
    GH_TOKEN = "$(cat ${config.age.secrets.gh-token.path})";
    CR_PAT = "$(cat ${config.age.secrets.ghcr_ro_token.path})";
  };

  home.sessionVariables = {
    GH_TOKEN = "$(cat ${config.age.secrets.gh-token.path})";
    CR_PAT = "$(cat ${config.age.secrets.ghcr_ro_token.path})";
  };

  programs.gh-dash = {
    enable = true;
    settings = {
      repoPaths = {
        "tunecore/*"    = "${opts.directories.work}/tunecore/repositories/";
        "odoo/*"        = "${opts.directories.work}/odoo/repositories/";
        "sreedevk/*"    = "${opts.directories.repositories}/sreedevk";
      };
      prSections = [
        {
          title = "Self Authored PRs";
          filters = "is:open author:@me";
        }
      ];
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
        co  = "pr checkout";
        rv  = "repo view --web";
        prc = "pr create";
      };
      editor = "nvim";
      pager = "bat";
      http_unix_socket = "";
      browser = "${opts.desktop.browser.bin or ""}";
    };
  };
}
