{ pkgs, lib, config, stylix, firefox-addons, system, ... }:
let
  nixglmod = import ./nixGL.nix { inherit lib config pkgs; };
in
{
  stylix.targets.firefox.enable = true;

  programs.firefox = {
    enable = true;
    package = nixglmod.nixGLWrapped pkgs.firefox-bin "firefox";
    profiles.main = {
      isDefault = true;
      containersForce = true;
      containers = {
        personal = {
          color = "red";
          icon = "tree";
          id = 1;
        };
        work = {
          color = "pink";
          icon = "briefcase";
          id = 2;
        };
      };
      extensions = with firefox-addons.packages."${system}"; [
        adnauseam
        bitwarden
        buster-captcha-solver
        consent-o-matic
        darkreader
        duckduckgo-privacy-essentials
        linkding-extension
        mullvad
        multi-account-containers
        noscript
        open-url-in-container
        reddit-enhancement-suite
        sidebery
        sponsorblock
        tab-reloader
        temporary-containers
        tubearchivist-companion
        ublock-origin
        vimium
      ];
      search = {
        force = true;
        default = "DuckDuckGo";
        privateDefault = "DuckDuckGo";
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

          "Firefox Addons" = {
            urls = [{
              template =
                "https://addons.mozilla.org/en-US/firefox/search/?q={searchTerms}";
            }];
            definedAliases = [ "@fa" ];
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

          "Brave" = {
            urls = [{
              template = "https://search.brave.com/search?q={searchTerms}";
            }];
            definedAliases = [ "@b" ];
          };

          "AnnasArchive" = {
            urls = [{
              template = "https://vec.annas-archive.se/search?q={searchTerms}";
            }];
            definedAliases = [ "@anna" ];
          };

          "WaybackMachine" = {
            urls = [{
              template = "https://web.archive.org/web/{searchTerms}";
            }];
            definedAliases = [ "@wb" ];
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
        # https://mozilla.github.io/policy-templates/
        "app.normandy.first_run" = false;
        "app.shield.optoutstudies.enabled" = false;
        "app.update.channel" = "default";
        "browser.aboutwelcome.enabled" = false;
        "browser.bookmarks.addedImportButton" = false;
        "browser.bookmarks.showMobileBookmarks" = false;
        "browser.contentblocking.category" = "standard";
        "browser.ctrlTab.recentlyUsedOrder" = false;
        "browser.discovery.enabled" = false;
        "browser.download.panel.shown" = true;
        "browser.download.useDownloadDir" = true;
        "browser.download.viewableInternally.typeWasRegistered.markdown" = true;
        "browser.download.viewableInternally.typeWasRegistered.md" = true;
        "browser.download.viewableInternally.typeWasRegistered.svg" = true;
        "browser.download.viewableInternally.typeWasRegistered.webp" = true;
        "browser.download.viewableInternally.typeWasRegistered.xml" = true;
        "browser.helperApps.deleteTempFileOnExit" = true;
        "browser.link.open_newwindow" = true;
        "browser.newtabpage.activity-stream.default.sites" = "";
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "browser.pocket.enabled" = false;
        "browser.safebrowsing.downloads.remote.enabled" = false;
        "browser.safebrowsing.malware.enabled" = false;
        "browser.safebrowsing.phishing.enabled" = false;
        "browser.search.widget.inNavBar" = true;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.startup.homepage" = "about:blank";
        "browser.toolbars.bookmarks.visibility" = "always";
        "browser.uitour.enabled" = false;
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "browser.urlbar.quickactions.enabled" = false;
        "browser.urlbar.quickactions.showPrefs" = false;
        "browser.urlbar.shortcuts.quickactions" = false;
        "browser.urlbar.showSearchSuggestionsFirst" = false;
        "browser.urlbar.suggest.calculator" = true;
        "browser.urlbar.suggest.quickactions" = false;
        "browser.vpn_promo.enabled" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "distribution.searchplugins.defaultLocale" = "en-US";
        "doh-rollout.balrog-migration-done" = true;
        "doh-rollout.doneFirstRun" = true;
        "dom.events.asyncClipboard.clipboardItem" = true;
        "dom.forms.autocomplete.formautofill" = false;
        "dom.security.https_only_mode" = true;
        "experiments.enabled" = false;
        "experiments.manifest.uri" = false;
        "experiments.supported" = false;
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "extensions.pocket.enabled" = false;
        "extensions.update.enabled" = false;
        "extensions.webcompat.enable_picture_in_picture_overrides" = true;
        "extensions.webcompat.enable_shims" = true;
        "extensions.webcompat.perform_injections" = true;
        "extensions.webcompat.perform_ua_overrides" = true;
        "general.autoScroll" = true;
        "general.useragent.locale" = "en-US";
        "geo.provider.use_geoclue" = false;
        "geo.provider.use_gpsd" = false;
        "identity.fxaccounts.enabled" = false;
        "media.ffmpeg.vaapi.enabled" = true;
        "network.allow-experiments" = false;
        "network.connectivity-service.enabled" = false;
        "print.print_footerleft" = "";
        "print.print_footerright" = "";
        "print.print_headerleft" = "";
        "print.print_headerright" = "";
        "privacy.donottrackheader.enabled" = true;
        "security.webauth.u2f" = true;
        "security.webauth.webauthn" = true;
        "security.webauth.webauthn_enable_softtoken" = true;
        "security.webauth.webauthn_enable_usbtoken" = true;
        "signon.management.page.breach-alerts.enabled" = false;
        "signon.rememberSignons" = false;
        "toolkit.coverage.endpoint.base" = "";
        "toolkit.coverage.opt-out" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.coverage.opt-out" = true;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.pioneer-new-studies-available" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.server" = "data:,";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabledFirstsession" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
      };
      bookmarks = [
        {
          name = "main";
          toolbar = true;
          bookmarks = [
            {
              name = "Subscribe (FreshRSS)";
              url = ''
                javascript: (function () {
                  var url = location.href;
                  var otherWindow = window.open('about:blank','_blank');
                  otherWindow.opener = null;
                  otherWindow.location = 'https://freshrss.nullptr.sh/i/?c=feed&a=add&url_rss='+encodeURIComponent(url);
                })();
              '';
            }
            {
              name = "Bookmark (Linkding)";
              url = ''
                javascript: (function () {
                  var bookmarkUrl = window.location;
                  var applicationUrl = 'https://links.nullptr.sh/bookmarks/new';
                  applicationUrl += '?url=' + encodeURIComponent(bookmarkUrl);
                  applicationUrl += '&auto_close';
                  window.open(applicationUrl);
                })();
              '';
            }
            {
              name = "nullptrderef1";
              url = "https://nullptr.sh";
            }
            {
              name = "hackernews";
              url = "https://news.ycombinator.com/";
            }
            {
              name = "lobsters";
              url = "https://lobste.rs/";
            }
          ];
        }
      ];
    };
  };
}
