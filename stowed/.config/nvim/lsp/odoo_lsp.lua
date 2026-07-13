---@type vim.lsp.Config
return {
  cmd = { "odoo-lsp" },
  filetypes = {
    "javascript",
    "xml",
    "python",
  },
  root_markers = {
    {
      ".odoo_lsp",
      ".odoo_lsp.json",
    },
    ".git",
  },
}
