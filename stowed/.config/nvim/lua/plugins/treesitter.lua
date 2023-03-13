return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'windwp/nvim-ts-autotag',
  },
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        "c", "elixir", "ruby", "lua", "rust", "json", "cpp",
        "eex", "heex", "org", "typescript", "go", "yaml", "html",
        "markdown", "markdown_inline"
      },
      autotag = {
        enable = true,
        filetypes = { "html" },
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        disable = function(_lang, buf)
          local max_filesize = 40000000
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn", -- set to `false` to disable one of the mappings
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
      indent = {
        enable = true
      },
    })
  end
}
