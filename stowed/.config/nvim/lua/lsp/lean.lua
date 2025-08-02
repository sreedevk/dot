require('core.utils').setup_lsp {
  name = 'leanls',
  enable = true,
  custom = false,
  filetypes = { 'lean' },
  cmd = { 'lean', '--server' },
  root_markers = { '.git', 'leanpkg.toml' }
}
