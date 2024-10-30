return {
  'akinsho/toggleterm.nvim',
  lazy = true,
  version = '*',
  cmd = "ToggleTerm",
  keys = { '<Leader>tr', '<Leader>tf', '<Leader>rs', '<Leader>rn' },
  config = function()
    require('toggleterm').setup()

    function _G.arun()
      local term    = require('toggleterm.terminal').Terminal
      local command = vim.fn.input("async cmd: ", "", "file")
      command       = string.gsub(command, '%%', vim.fn.expand('%'))
      local cmdterm = term:new({ cmd = command, hidden = false })
      cmdterm:spawn()
    end

    vim.api.nvim_create_user_command('RunAsync', ":lua arun()", {})

    vim.api.nvim_set_keymap('n', '<Leader>tr', "<cmd>ToggleTerm<CR>", { noremap = true })
    vim.api.nvim_set_keymap('n', '<Leader>tf', "<cmd>ToggleTerm direction=float<CR>", { noremap = true })
    vim.api.nvim_set_keymap('v', '<Leader>rs', ":'>ToggleTermSendVisualLine<CR>", { noremap = true })
    vim.api.nvim_set_keymap('n', '<Leader>rn', ':RunAsync ', { noremap = true })
  end
}
