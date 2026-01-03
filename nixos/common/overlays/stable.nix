{ inputs, ... }:
_: prev: {
  inherit (inputs.stablepkgs.legacyPackages.${prev.stdenv.hostPlatform.system})
    adguard
    ardour
    awscli2
    davinci-resolve
    gurk-rs
    imager
    jellyfin-media-player
    obs-studio
    obs-studio-plugins
    silicon
    ;
}
