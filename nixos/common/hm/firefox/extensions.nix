{ pkgs, ... }:
with pkgs.nur.repos.rycee.firefox-addons;
[
  bitwarden
  consent-o-matic
  darkreader
  dearrow
  decentraleyes
  karakeep
  private-grammar-checker-harper
  reddit-enhancement-suite
  sponsorblock
  tridactyl
  ublock-origin
]
