{ inputs, ... }:
_: prev: {
  inherit (inputs.stablepkgs.legacyPackages.${prev.stdenv.hostPlatform.system})
    ardour
    awscli2
    jellyfin-media-player
    ledger
    libvdpau-va-gl
    lmms
    obs-studio
    obs-studio-plugins
    sonic-pi
    ;
}
