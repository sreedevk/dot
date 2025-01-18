{ firefox-addons, system, ... }:
with firefox-addons.packages."${system}"; [
  adnauseam
  bitwarden
  consent-o-matic
  darkreader
  enhancer-for-youtube
  # NOTE: Check TODO. 
  # hoarder
  multi-account-containers
  open-url-in-container
  reddit-enhancement-suite
  sponsorblock
  tab-reloader
  temporary-containers
  tubearchivist-companion
  ublock-origin
  vimium
]
