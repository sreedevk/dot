{ pkgs, ... }:
with pkgs.nur.repos.rycee.firefox-addons;
[
  bitwarden
  consent-o-matic
  darkreader
  private-grammar-checker-harper
  tampermonkey
  ublock-origin
  vimium
]
