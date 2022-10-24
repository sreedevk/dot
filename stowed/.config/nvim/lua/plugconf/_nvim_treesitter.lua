local status_ok, nvim_treesitter_config = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

nvim_treesitter_config.setup {
  ensure_installed = "all",
  sync_install     = false,
  auto_install     = true,
  highlight        = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = { enable = true }
}
