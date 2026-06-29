{ inputs, ... }:
_: prev: {
  inherit (inputs.stablepkgs.legacyPackages.${prev.stdenv.hostPlatform.system})
    adguard
    beets
    bitwarden-desktop
    claude-code
    neovim
    imager
    jiratui
    zls
    ;
}
