{ inputs, ... }:
[
  inputs.nixgl.overlay
  inputs.nur.overlays.default
  inputs.niri.overlays.niri
  (import ./agenix.nix       { inherit inputs; })
  (import ./stable.nix       { inherit inputs; })
  (import ./nvidia.nix       { inherit inputs; })
  (import ./colmena.nix      { inherit inputs; })
  (import ./attic.nix        { inherit inputs; })
  (import ./home-manager.nix { inherit inputs; })
  (import ./noctalia.nix     { inherit inputs; })
  (import ./llama-cpp.nix    { inherit inputs; })
  (import ./vicinae.nix      { inherit inputs; })
]
