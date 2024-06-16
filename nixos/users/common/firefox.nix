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
      ];
      search = {
        force = true;
        default = "DuckDuckGo";
        engines = {
          "Nix Packages" = {
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

          "NixOS Options" = {
            urls = [{
              template = "https://search.nixos.org/options";
              params = [
                {
                  name = "channel";
                  value = "unstable";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }];
            definedAliases = [ "@no" ];
          };

          "NixOS Wiki" = {
            urls = [{ template = "https://wiki.nixos.org/index.php?search={searchTerms}"; }];
            iconUpdateURL = "https://wiki.nixos.org/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@nw" ];
          };

          "HomeManager" = {
            urls = [{ template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=master"; }];
            iconUpdateURL = "https://wiki.nixos.org/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@hm" ];
          };

          "Reddit" = {
            urls = [{
              template = "https://old.reddit.com/search";
              params = [
                {
                  name = "q";
                  value = "{searchTerms}";
                }
                {
                  name = "include_over_18";
                  value = "on";
                }
              ];
            }];
            definedAliases = [ "@r" ];
          };

          "DuckDuckGo" = {
            urls = [{ template = "https://duckduckgo.com/?q={searchTerms}"; }];
          };

          "GitHub" = {
            urls = [{
              template = "https://github.com/search";
              params = [{
                name = "q";
                value = "{searchTerms}";
              }];
            }];
            definedAliases = [ "@gh" ];
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
        "browser.toolbars.bookmarks.visibility" = "never";
      };
      bookmarks = [
        {
          toolbar = true;
          bookmarks = [
            {
              name = "wikipedia";
              tags = [ "wiki" ];
              keyword = "wiki";
              url = "https://en.wikipedia.org";
            }
          ];
        }
      ];
    };
  };
}
