vim.lsp.enable({
  "astro",
  "bacon_ls",
  "clojure_lsp",
  "elixirls",
  "elmls",
  "erlangls",
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
