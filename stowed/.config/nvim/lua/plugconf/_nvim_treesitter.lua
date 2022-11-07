local status_ok, nvim_treesitter_config = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

nvim_treesitter_config.setup {
  ensure_installed = "all",
  autotag = { enable = true },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },
  content_commentstring = {
    enable = true,
    enable_autocmd = false
  },
  rainbow = {
    enable = true,
    disable = { "html" },
    extended_mode = false,
    max_file_lines = nil
  },
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

local nvim_treesitter_install_ok, nvim_treesitter_install = pcall(require, "nvim-treesitter.install")
if nvim_treesitter_install_ok then
  nvim_treesitter_install.update({ with_sync = true })
end
