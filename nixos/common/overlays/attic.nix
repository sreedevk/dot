{ inputs, ... }:
_: prev: {
  inherit (inputs.attic.packages.${prev.system}) attic-client;
}
