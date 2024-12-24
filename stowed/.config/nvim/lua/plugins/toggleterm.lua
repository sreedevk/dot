return {
  'akinsho/toggleterm.nvim',
  lazy = true,
  version = '*',
  cmd = "ToggleTerm",
  keys = {
    { '<Leader>tro', "<cmd>ToggleTerm<CR>",                  noremap = true },
    { '<Leader>trf', "<cmd>ToggleTerm direction=float<CR>",  noremap = true },
    { '<Leader>trs', ":'>ToggleTermSendVisualSelection<CR>", noremap = true, mode = 'v' },
    { '<Leader>trs', ":ToggleTermSendCurrentLine<CR>",       noremap = true }
  },
  config = function()
    require('toggleterm').setup()

    function _G.arun()
      local term    = require('toggleterm.terminal').Terminal
      local command = string.gsub(vim.fn.input("async cmd: ", "", "file"), '%%', vim.fn.expand('%'))
      local cmdterm = term:new({ cmd = command, hidden = false })
      cmdterm:spawn()
    end

    vim.api.nvim_create_user_command('RunAsync', ":lua arun()", {})
    vim.keymap.set('n', '<Leader>trn', '<cmd>RunAsync<CR> ', { noremap = true })
  end
}
