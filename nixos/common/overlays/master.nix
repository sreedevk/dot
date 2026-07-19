{ inputs, ... }:
_: prev: {
  inherit (inputs.nixpkgs-master.legacyPackages.${prev.stdenv.hostPlatform.system})
    tmuxinator
    ;
}
