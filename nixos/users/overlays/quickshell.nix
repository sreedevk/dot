{ inputs, ... }:
final: prev: {
  quickshell = inputs.quickshell.packages.${prev.system}.default;
}
