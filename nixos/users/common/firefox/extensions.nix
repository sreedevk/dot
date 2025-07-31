{ pkgs, system, ... }:
with pkgs.nur.repos.rycee.firefox-addons; [
  bitwarden
  consent-o-matic
  darkreader
  decentraleyes
  enhancer-for-youtube
  karakeep
  private-grammar-checker-harper
  reddit-enhancement-suite
  sponsorblock
  tab-reloader
  tubearchivist-companion
  ublock-origin
  vimium
]

