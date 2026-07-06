{ inputs, ... }:
_: prev: {
  inherit (inputs.stablepkgs.legacyPackages.${prev.stdenv.hostPlatform.system})
    adguard
    beets
    bitwarden-desktop
    claude-code
    imager
    jellyfin-desktop
    jiratui
    neovim
    zls
    ;
}
