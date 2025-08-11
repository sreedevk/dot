require('core.utils').setup_lsp {
  name = 'pylsp',
  enable = true,
  custom = false,
  cmd = { 'pylsp' },
  filetypes = { 'python' },
  root_markers = {
    '.git',
    'Pipfile',
    'pyproject.toml',
    'requirements.txt',
    'setup.cfg',
    'setup.py',
    'uv.lock',
  },
}
