{ inputs, ... }:
final: _: {
  librepods = inputs.librepods.packages.${final.system}.default;
}
