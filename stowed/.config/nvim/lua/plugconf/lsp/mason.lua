local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
  return
end

mason_lspconfig.setup({
  ensure_installed = {
    "tsserver",
    "html",
    "cssls",
    "tailwindcss",
    "sumneko_lua",
    "rust_analyzer",
    "solargraph",
    "clojure_lsp",
    "elixirls",
    "gopls",
    "julials",
    "texlab",
    "marksman",
    "ocamllsp",
    "pyright",
    "sqlls",
    "svelte",
    "rescriptls",
    "graphql",
    "dockerls",
    "denols",
    "clangd",
    "asm_lsp"
  }
})
