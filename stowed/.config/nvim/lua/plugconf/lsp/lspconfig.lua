local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
  return
end

local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_ok then
  return
end

local keymap = vim.keymap

local on_attach = function(client, buff)
  -- keybind options
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- set keybinds
  keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
  keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
  keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
  keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
  keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
  keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
  keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
  keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
  keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
  keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
  keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
  keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

lspconfig["html"].setup({ capabilities = capabilities, on_attach = on_attach, })
lspconfig["tsserver"].setup({ capabilities = capabilities, on_attach = on_attach, })
lspconfig["cssls"].setup({ capabilities = capabilities, on_attach = on_attach, })
lspconfig["tailwindcss"].setup({ capabilities = capabilities, on_attach = on_attach, })
lspconfig["rust_analyzer"].setup({ capabilities = capabilities, on_attach = on_attach, })
lspconfig["solargraph"].setup({ capabilities = capabilities, on_attach = on_attach, })
lspconfig["clojure_lsp"].setup({ capabilities = capabilities, on_attach = on_attach, })
lspconfig["elixirls"].setup({ capabilities = capabilities, on_attach = on_attach, })
lspconfig["erlangls"].setup({ capabilities = capabilities, on_attach = on_attach, })
lspconfig["gopls"].setup({ capabilities = capabilities, on_attach = on_attach, })
lspconfig["hls"].setup({ capabilities = capabilities, on_attach = on_attach, })
lspconfig["julials"].setup({ capabilities = capabilities, on_attach = on_attach, })
lspconfig["texlab"].setup({ capabilities = capabilities, on_attach = on_attach, })
lspconfig["marksman"].setup({ capabilities = capabilities, on_attach = on_attach, })
lspconfig["ocamllsp"].setup({ capabilities = capabilities, on_attach = on_attach, })
lspconfig["pyright"].setup({ capabilities = capabilities, on_attach = on_attach, })
lspconfig["sqlls"].setup({ capabilities = capabilities, on_attach = on_attach, })
lspconfig["svelte"].setup({ capabilities = capabilities, on_attach = on_attach, })
lspconfig["rescriptls"].setup({ capabilities = capabilities, on_attach = on_attach, })
lspconfig["graphql"].setup({ capabilities = capabilities, on_attach = on_attach, })
lspconfig["dockerls"].setup({ capabilities = capabilities, on_attach = on_attach, })
lspconfig["denols"].setup({ capabilities = capabilities, on_attach = on_attach, })
lspconfig["clangd"].setup({ capabilities = capabilities, on_attach = on_attach, })
lspconfig["asm_lsp"].setup({ capabilities = capabilities, on_attach = on_attach, })
lspconfig["sumneko_lua"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true
        }
      }
    }
  }
})
