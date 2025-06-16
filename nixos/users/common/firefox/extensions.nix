# TODO: hoarder was hit with a dmca notice, plugin removed from firefox store
#       will restore after the plugin is reinstated with the new name "karakeep"

{ firefox-addons, system, ... }:
with firefox-addons.packages."${system}"; [
  adnauseam
  bitwarden
  consent-o-matic
  darkreader
  enhancer-for-youtube
  karakeep
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

