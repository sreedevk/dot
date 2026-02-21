vim.lsp.enable({
  "ast_grep",
  "astro",
  "bacon_ls",
  "clojure_lsp",
  "elixirls",
  "elmls",
  "elp", -- erlang
  "emmet_language_server",
  "eslint",
  "fennel_ls",
  "gleam",
  "hls",
  "html",
  "janet_lsp",
  "jsonls",
  "jsonnet_ls",
  "ltex_plus",
  "lua_ls",
  "marksman",
  "metals",
  "nil_ls",
  "nimls",
  "ocamllsp",
  "pylsp",
  "ruby_lsp",
  "rust_analyzer",
  "scheme_langserver",
  "syntax_tree",
  "tailwindcss",
  "taplo",
  "tinymist",
  "ts_ls",
  "yamlls",
  "zls",
})

vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = { enable = false },
      diagnostics = { enable = false } -- disable this when using "bacon_ls" as a diagnostics lsp for rust
    }
  }
})
