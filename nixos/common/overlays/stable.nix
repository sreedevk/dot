{ inputs, ... }:
_: prev: {
  inherit (inputs.stablepkgs.legacyPackages.${prev.stdenv.hostPlatform.system})
    adguard
    bitwarden-desktop
    feishin
    imager
    jiratui
    zls
    beets
    ;
}
