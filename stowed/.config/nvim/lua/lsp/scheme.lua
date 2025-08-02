require('core.utils').setup_lsp {
  name = 'chicken-scheme-lsp',
  custom = true,
  enable = true,
  filetypes = { 'scheme' },
  cmd = { 'chicken-lsp-server' },
}
