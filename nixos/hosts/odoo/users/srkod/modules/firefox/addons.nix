{ pkgs, ... }:
with pkgs.nur.repos.rycee.firefox-addons;
[
  bitwarden
  consent-o-matic
  darkreader
  sponsorblock
  ublock-origin
  vimium
  youtube-shorts-block
]
