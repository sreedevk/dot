require('core.utils').setup_lsp {
  name = 'rust_analyzer',
  enable = true,
  custom = false,
  filetypes = { 'rust' },
  cmd = { 'rust-analyzer' },
  root_markers = { 'Cargo.toml', 'Cargo.lock' },
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = { enable = false },
      diagnostics = { enable = false },
      imports = {
        granularity = { group = "module" },
        prefix = "self",
      },
      cargo = {
        buildScripts = { enable = true },
      },
      procMacro = { enable = true },
    }
  }
}

require('core.utils').setup_lsp {
  name = 'bacon_ls',
  enable = true,
  custom = false,
  filetypes = { 'rust' },
  cmd = { 'bacon-ls' },
  root_markers = { '.bacon-locations', 'Cargo.toml', 'Cargo.lock' },
  init_options = {
    updateOnSave = true,
    updateOnSaveWaitMillis = 1000,
    updateOnChange = false,
  }
}
