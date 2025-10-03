{ inputs, ... }:
_: prev: {
  inherit (inputs.colmena.packages.${prev.system}) colmena;
}
