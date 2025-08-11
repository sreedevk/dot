require('core.utils').setup_lsp {
  name = 'taplo',
  enable = true,
  custom = false,
  filetypes = { 'toml' },
  cmd = { 'taplo', 'lsp', 'stdio' },
}
