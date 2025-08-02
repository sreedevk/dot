require('core.utils').setup_lsp {
  name = 'nil_ls',
  enable = true,
  custom = false,
  filetypes = { 'nix' },
  cmd = { 'nil' },
  root_markers = { 'flake.nix', 'flake.lock' },
  settings = {
    ["nil"] = {
      formatting = {
        command = { "nixpkgs-fmt" },
      },
    },
  }
}
