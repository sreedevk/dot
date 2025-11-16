{ inputs, ... }:
_: prev: {
  mango = inputs.mango.packages.${prev.stdenv.hostPlatform.system}.default;
}
