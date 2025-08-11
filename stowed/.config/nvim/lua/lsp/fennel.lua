require('core.utils').setup_lsp {
  name = 'fennel_language_server',
  enable = true,
  custom = false,
  filetypes = { 'fennel' },
  cmd = { 'fennel-ls' },
}
