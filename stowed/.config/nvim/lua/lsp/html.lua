require('core.utils').setup_lsp {
  name = 'vscode-html-language-server',
  enable = false,
  custom = false,
  filetypes = { 'html', 'templ' },
  cmd = { 'vscode-html-language-server', '--stdio' },
  init_options = {
    provideFormatter = true,
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { 'html', 'css', 'javascript' },
  },
}
