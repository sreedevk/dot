{ inputs, ... }:
_: prev: {
  inherit (inputs.stablepkgs.legacyPackages.${prev.stdenv.hostPlatform.system})
    adguard
    beets
    bitwarden-desktop
    claude-code
    feishin
    imager
    jiratui
    zls
    ;
}
