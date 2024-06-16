{ pkgs, secrets, lib, inputs, system, ... }: {
  programs.firefox = {
    enable = true;
    profiles.main = {
      isDefault = true;
      extensions = with inputs.firefox-addons.packages."${system}"; [
        bitwarden
        vimium
        ublock-origin
        darkreader
        linkding-extension
        consent-o-matic
      ];
      search = {
        force = true;
        default = "DuckDuckGo";
        engines = {
          "Nix Packages" = {
            urls = [{
              template =
                "https://search.nixos.org/packages?type=packages&query={searchTerms}&channel=unstable&size=100";
            }];
            definedAliases = [ "@np" ];
          };

          "NixOS Options" = {
            urls = [{
              template =
                "https://search.nixos.org/options?channel=unstable&query={searchTerms}";
            }];
            definedAliases = [ "@no" ];
          };

          "NixOS Wiki" = {
            urls = [{
              template =
                "https://wiki.nixos.org/index.php?search={searchTerms}";
            }];
            definedAliases = [ "@nw" ];
          };

          "YouTube" = {
            urls = [{
              template =
                "https://www.youtube.com/results?search_query={searchTerms}";
            }];
            definedAliases = [ "@yt" ];
          };

          "HomeManager" = {
            urls = [{
              template =
                "https://home-manager-options.extranix.com?query={searchTerms}&release=master";
            }];
            definedAliases = [ "@hm" ];
          };

          "Reddit" = {
            urls = [{
              template =
                "https://old.reddit.com/search?q={searchTerms}&include_over_18=on";
            }];
            definedAliases = [ "@r" ];
          };

          "DuckDuckGo" = {
            urls = [{
              template =
                "https://duckduckgo.com?q={searchTerms}";
            }];
            definedAliases = [ "@ddg" ];
          };

          "GitHub" = {
            urls = [{
              template =
                "https://github.com/search?q={searchTerms}";
            }];
            definedAliases = [ "@gh" ];
          };

          "Flatpak" = {
            urls = [{ template = "https://flathub.org/apps/search?q={searchTerms}"; }];
            definedAliases = [ "@fp" ];
          };

          "Bing".metaData.hidden = true;
          "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
          "Wikipedia (en)".metaData.alias = "@w";
        };
      };
      settings = {
        "dom.security.https_only_mode" = true;
        "browser.download.panel.shown" = true;
        "identity.fxaccounts.enabled" = false;
        "signon.rememberSignons" = false;
        "media.ffmpeg.vaapi.enabled" = true;
        "browser.aboutwelcome.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.startup.homepage" = "about:blank";
        "browser.pocket.enabled" = false;
        "extensions.pocket.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "signon.management.page.breach-alerts.enabled" = false;
        "browser.safebrowsing.malware.enabled" = false;
        "browser.safebrowsing.phishing.enabled" = false;
        "browser.safebrowsing.downloads.remote.enabled" = false;
        "extensions.update.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "browser.ping-centre.telemetry" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.pioneer-new-studies-available" = false;
        "experiments.supported" = false;
        "experiments.enabled" = false;
        "experiments.manifest.uri" = false;
        "network.allow-experiments" = false;
        "dom.events.asyncClipboard.clipboardItem" = true;
        "browser.bookmarks.addedImportButton" = false;
        "browser.toolbars.bookmarks.visibility" = "always";
      };
      bookmarks = [
        {
          name = "main";
          toolbar = true;
          bookmarks = [
            {
              name = "nullptrderef1";
              url = "http://nullptrderef1/";
            }
            {
              name = "hackernews";
              url = "https://news.ycombinator.com/";
            }
            {
              name = "add bookmark";
              url = ''
                javascript: (function () {
                  var bookmarkUrl = window.location;
                  var applicationUrl = 'http://nullptrderef1:9090/bookmarks/new';
                  applicationUrl += '?url=' + encodeURIComponent(bookmarkUrl);
                  applicationUrl += '&auto_close';  window.open(applicationUrl);})();
              '';
            }
          ];
        }
      ];
    };
  };
}
