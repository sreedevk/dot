local lsp_ok, lsp = pcall(require, "lsp-zero")
if not lsp_ok then
  return
end

lsp.preset("recommended")
lsp.nvim_workspace()
lsp.setup()
