require('core.utils').setup_lsp {
  name = 'tailwindcss',
  enable = true,
  custom = false,
  filetypes = {
    'html',
    'css',
    'scss',
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    'vue',
    'svelte',
    'astro',
  },
  cmd = { 'bun', 'x', '@tailwindcss/language-server', '--stdio' },
  root_markers = { 'package.json', 'yarn.lock', 'bun.lock', 'package.lock' }
}
