require('core.utils').setup_lsp {
  name = 'janet-lsp',
  enable = true,
  custom = true,
  filetypes = { 'janet' },
  cmd = { 'janet-lsp' },
  root_markers = { 'project.janet', '.git' }
}
