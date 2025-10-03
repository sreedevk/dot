{ inputs, ... }:
_: prev: {
  agenix = inputs.agenix.packages.${prev.system}.default;
}
