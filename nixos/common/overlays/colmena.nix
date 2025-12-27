{ inputs, ... }:
_: prev: {
  inherit (inputs.colmena.packages.${prev.stdenv.hostPlatform.system}) colmena;
}
