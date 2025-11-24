{ inputs, ... }:
_: prev: {
  inherit (inputs.stablepkgs.legacyPackages.${prev.stdenv.hostPlatform.system})
    awscli2
    ardour
    jellyfin-media-player
    obs-studio
    obs-studio-plugins
    adguard
    ;
}
