let
  apollo      = import ./secrets/apollo;
  devtechnica = import ./secrets/devtechnica;
  lyra        = import ./secrets/lyra;
  odoo        = import ./secrets/odoo;
  orion       = import ./secrets/orion;
  phoenix     = import ./secrets/phoenix;
  rpi4b       = import ./secrets/rpi4b;
in
with builtins;
foldl' (x: y: x // y) { } [
  apollo
  devtechnica
  lyra
  odoo
  orion
  phoenix
  rpi4b
]
