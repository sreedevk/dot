require('core.utils').setup_lsp {
  name = 'nim_langserver',
  enable = true,
  custom = false,
  cmd = { 'nimlangserver' },
  filetypes = { 'nim' },
  root_markers = { '.git' }
}
