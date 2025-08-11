require('core.utils').setup_lsp {
  name = 'ts_ls',
  enable = true,
  custom = false,
  filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
  cmd = { 'bun', 'x', 'typescript-language-server', '--stdio' },
  root_markers = { 'package.json', 'yarn.lock', 'bun.lock' },
  init_options = {
    hostInfo = "neovim"
  }
}
