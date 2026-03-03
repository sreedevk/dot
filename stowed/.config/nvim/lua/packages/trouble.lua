return {
  "folke/trouble.nvim",
  opts = {},
  cmd = "Trouble",
  keys = {
    { "<leader>xt",  "<cmd>Trouble todo toggle<cr>",                                   desc = "Todo (Trouble)" },
    { "<leader>xT",  "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
    { "<leader>xx",  "<cmd>Trouble diagnostics toggle<cr>",                            desc = "Diagnostics (Trouble)" },
    { "<leader>xb",  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",               desc = "Buffer Diagnostics (Trouble)" },
    { "<leader>xs",  "<cmd>Trouble symbols toggle focus=false<cr>",                    desc = "Symbols (Trouble)" },
    { "<leader>xls", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",     desc = "LSP Definitions / references / ... (Trouble)" },
    { "<leader>xlo", "<cmd>Trouble loclist toggle<cr>",                                desc = "Location List (Trouble)" },
    { "<leader>xq",  "<cmd>Trouble qflist toggle<cr>",                                 desc = "Quickfix List (Trouble)" },
  },
}
