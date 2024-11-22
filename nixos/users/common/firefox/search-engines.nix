{
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
    definedAliases = [ "@dd" ];
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
}
