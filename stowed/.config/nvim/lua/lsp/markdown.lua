require('core.utils').setup_lsp {
  name = 'marksman',
  enable = true,
  custom = false,
  filetypes = { 'markdown', 'markdown.mdx' },
  cmd = { 'marksman', 'server' }
}
