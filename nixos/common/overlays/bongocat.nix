{ inputs, ... }:
_: prev: {
  bongocat = inputs.bongocat.packages.${prev.stdenv.hostPlatform.system}.default;
}
