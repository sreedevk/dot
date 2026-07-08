{ pkgs, ... }:
let
  rycee = pkgs.nur.repos.rycee;
  vimium-new-tab-page = rycee.firefox-addons.buildFirefoxXpiAddon {
    pname = "vimium-new-tab-page";
    version = "1.0";
    addonId = "@vimium-new-tab";
    url = "https://addons.mozilla.org/firefox/downloads/file/4612990/vimium_new_tab_page-1.0.xpi";
    sha256 = "sha256-NuaTGE57twd3LenqGDS8vNwzVRrrELM/bwcvhntKMt0=";
    meta = { };
  };
in
with rycee.firefox-addons;
[
  bitwarden
  consent-o-matic
  darkreader
  dearrow
  decentraleyes
  duckduckgo-privacy-essentials
  karakeep
  private-grammar-checker-harper
  reddit-enhancement-suite
  sponsorblock
  ublock-origin
  vimium
  youtube-shorts-block
  vimium-new-tab-page
]
