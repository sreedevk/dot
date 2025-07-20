# TODO: hoarder was hit with a dmca notice, plugin removed from firefox store
#       will restore after the plugin is reinstated with the new name "karakeep"

{ firefox-addons, system, ... }:
with firefox-addons.packages."${system}"; [
  bitwarden
  consent-o-matic
  darkreader
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

