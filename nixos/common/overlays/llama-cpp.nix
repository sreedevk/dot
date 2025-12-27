{ inputs, ... }:
_: prev: {
  llama-cpp = inputs.llama-cpp.packages.${prev.stdenv.hostPlatform.system}.default;
}
