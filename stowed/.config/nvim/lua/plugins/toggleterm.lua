return {
  'akinsho/toggleterm.nvim',
  lazy = true,
  version = '*',
  cmd = "ToggleTerm",
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
    vim.api.nvim_set_keymap('n', '<Leader>rn', ':RunAsync ')
  end
}
