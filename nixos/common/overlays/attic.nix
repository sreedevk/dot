{ inputs, ... }:
_: prev: {
  inherit (inputs.attic.packages.${prev.stdenv.hostPlatform.system}) attic-client;
}
