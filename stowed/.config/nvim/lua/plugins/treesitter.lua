return {
  'nvim-treesitter/nvim-treesitter',
  lazy = true,
  event = "BufReadPost",
  dependencies = {
    'windwp/nvim-ts-autotag'
  },
  config = function()
    vim.api.nvim_set_option_value("foldmethod", "expr", {})
    vim.api.nvim_set_option_value("foldexpr", "nvim_treesitter#foldexpr()", {})

    require('nvim-treesitter.configs').setup({
      ensure_installed = { "bash", "c", "cpp", "css", "diff", "eex", "elixir", "gleam", "haskell", "heex", "html", "javascript", "jq", "json", "ledger", "lua", "python", "ruby", "rust", "ssh_config", "toml", "tsv", "typescript", "yaml", "zig", },
      autotag = {
        enable = true,
        filetypes = { "html" },
      },
      sync_install = true,
      ignore_install = { "comment" },
      auto_install = false,
      incremental_selection = { enable = false },
      indent = { enable = true },
      playground = {
        enable = true,
        disable = {},
        updatetime = 50,        -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = true, -- Whether the query persists across vim sessions
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = function(_, buf)
          local max_filesize = 40000000
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      }
    })
  end
}
