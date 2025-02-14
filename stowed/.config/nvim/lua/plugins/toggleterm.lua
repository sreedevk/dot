return {
  'akinsho/toggleterm.nvim',
  lazy = true,
  version = '*',
  cmd = { "ToggleTerm", "TermExec", "TermSelect" },
  keys = {
    {
      '<Leader>tt',
      function()
        local trim_spaces = false
        require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = vim.v.count, })
      end,
      noremap = true,
      desc = "send line to term",
    },
    {
      '<Leader>tt',
      function()
        local trim_spaces = false
        require("toggleterm").send_lines_to_terminal("visual_selection", trim_spaces, { args = vim.v.count })
      end,
      noremap = true,
      desc = "send visual to term",
      mode = "v",
    },
    {
      '<C-4><C-4>',
      "<cmd>ToggleTerm direction=horizontal<CR>",
      noremap = true,
      desc = "Toggle Terminal (Bottom)",
      mode = { "t", "n", "i" },
    },
    {
      '<C-3><C-3>',
      "<cmd>ToggleTerm direction=float<CR>",
      noremap = true,
      desc = "Toggle Terminal (Float)",
      mode = { "t", "n", "i" },
    },
  },
  opts = {},
  config = true
}
