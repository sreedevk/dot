require('core.utils').setup_lsp {
  name = 'vscode-css-language-server',
  enable = true,
  custom = false,
  cmd = { 'vscode-css-language-server', '--stdio' },
  filetypes = { 'css', 'scss', 'less' },
  init_options = { provideFormatter = true },
  settings = {
    css = { validate = true },
    scss = { validate = true },
    less = { validate = true },
  },
}
