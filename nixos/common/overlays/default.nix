{ inputs, opts, ... }:
[
  inputs.nur.overlays.default
  inputs.niri.overlays.niri
  (import ./agenix.nix            { inherit inputs opts; })
  (import ./stable.nix            { inherit inputs opts; })
  (import ./master.nix            { inherit inputs opts; })
  (import ./colmena.nix           { inherit inputs opts; })
  (import ./attic.nix             { inherit inputs opts; })
  (import ./home-manager.nix      { inherit inputs opts; })
  (import ./noctalia.nix          { inherit inputs opts; })
  (import ./llama-cpp.nix         { inherit inputs opts; })
  (import ./vicinae.nix           { inherit inputs opts; })
]
