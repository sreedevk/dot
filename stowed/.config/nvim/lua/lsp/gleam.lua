require('core.utils').setup_lsp {
  name = 'gleam',
  enable = true,
  custom = false,
  filetypes = { 'gleam' },
  cmd = { 'gleam', 'lsp' },
  root_markers = { 'gleam.toml', '.git' }
}
