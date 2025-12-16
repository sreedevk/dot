{ inputs, ... }:
_: prev: {
  inherit (inputs.stablepkgs.legacyPackages.${prev.stdenv.hostPlatform.system})
    adguard
    ardour
    awscli2
    davinci-resolve
    jellyfin-media-player
    obs-studio
    obs-studio-plugins
    ;
}
