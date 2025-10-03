{ inputs, ... }:
final: prev: {
  colmena = inputs.colmena.packages.${prev.system}.colmena;
}
