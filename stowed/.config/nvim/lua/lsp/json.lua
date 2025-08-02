require('core.utils').setup_lsp {
  name = "jsonls",
  enable = true,
  custom = false,
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  init_options = { provideFormatter = true },
}
