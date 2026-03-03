{ inputs, ... }:
_: prev: {
  inherit (inputs.stablepkgs.legacyPackages.${prev.stdenv.hostPlatform.system})
    adguard
    imager
    jiratui
    zls
    beets
    ;
}
