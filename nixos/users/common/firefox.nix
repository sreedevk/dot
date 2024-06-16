{ pkgs, secrets, lib, inputs, system, ... }: {
  programs.firefox = {
    enable = true;
    profiles.main = {
      extensions = [
        inputs.firefox-addons.packages."${system}".bitwarden
        inputs.firefox-addons.packages."${system}".vimium
        inputs.firefox-addons.packages."${system}".ublock-origin
        inputs.firefox-addons.packages."${system}".darkreader
      ];
      search = {
        force = true;
        engines = {
          "NixPackages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@nix" ];
          };

          "NixOS Wiki" = {
            urls = [{ template = "https://wiki.nixos.org/index.php?search={searchTerms}"; }];
            iconUpdateURL = "https://wiki.nixos.org/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@nw" ];
          };

          "DuckDuckGo" = {
            urls = [{ template = "https://duckduckgo.com/?q={searchTerms}"; }];
          };

          "Bing".metaData.hidden = true;
          "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
        };
      };
      settings = {
        "dom.security.https_only_mode" = true;
        "browser.download.panel.shown" = true;
        "identity.fxaccounts.enabled" = false;
        "signon.rememberSignons" = false;
      };
      bookmarks = [
        # {
        # name = "wikipedia";
        # tags = [ "wiki" ];
        # keyword = "wiki";
        # url = "https://en.wikipedia.org";
        # }
      ];
    };
  };
}
