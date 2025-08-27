{ inputs, ... }:
final: prev: {
  lmms = inputs.stablepkgs.legacyPackages.${prev.system}.lmms;
}
