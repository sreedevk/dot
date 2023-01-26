local nvim_ts_ok, nvim_ts = pcall(require, 'nvim-treesitter.configs')
if not nvim_ts_ok then
  return
end

nvim_ts.setup({
  ensure_installed = { "c", "elixir", "ruby", "lua", "rust", "cmake", "json", "sql", "bash", "svelte", "regex",
    "gitattributes", "diff", "clojure", "commonlisp", "dockerfile", "julia", "http", "css", "scss", "cpp", "markdown",
    "graphql", "erlang", "gleam", "eex", "heex", "ocaml", "haskell", "org", "typescript", "scala", "org", "go", "awk",
    "yaml", "toml", "fennel", "python", "html" },
  sync_install = true,
  auto_install = true,
  highlight = {
    enable = true,
    disable = function(_lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn", -- set to `false` to disable one of the mappings
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
    indent = { enable = true },
  }
})
