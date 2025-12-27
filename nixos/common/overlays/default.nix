{ inputs, opts, ... }:
[
  inputs.nixgl.overlay
  inputs.nur.overlays.default
  inputs.niri.overlays.niri
  (import ./nvidia.nix       { inherit inputs opts; })
  (import ./agenix.nix       { inherit inputs opts; })
  (import ./stable.nix       { inherit inputs opts; })
  (import ./colmena.nix      { inherit inputs opts; })
  (import ./attic.nix        { inherit inputs opts; })
  (import ./home-manager.nix { inherit inputs opts; })
  (import ./noctalia.nix     { inherit inputs opts; })
  (import ./llama-cpp.nix    { inherit inputs opts; })
  (import ./vicinae.nix      { inherit inputs opts; })
  (import ./bongocat.nix     { inherit inputs opts; })
]
