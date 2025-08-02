require('core.utils').setup_lsp {
  name = 'ltex_plus',
  enable = false,
  custom = false,
  cmd = { 'ltex-ls-plus' },
  filetypes = {
    'mail',
    'markdown',
    'mdx',
    'org',
    'pandoc',
    'plaintex',
    'text',
    'typst',
    'xhtml',
  },
}
