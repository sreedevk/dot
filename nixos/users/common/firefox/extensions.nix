{ firefox-addons, system, ... }:
with firefox-addons.packages."${system}"; [
  adnauseam
  bitwarden
  buster-captcha-solver
  clearcache
  consent-o-matic
  darkreader
  duckduckgo-privacy-essentials
  enhancer-for-youtube
  hoarder
  keybase
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
  web-archives
]
