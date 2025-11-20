{ inputs, ... }:
_: prev: {
  inherit (inputs.stablepkgs.legacyPackages.${prev.stdenv.hostPlatform.system})
    ardour
    jellyfin-media-player
    obs-studio
    obs-studio-plugins
    adguard
    ;
}
