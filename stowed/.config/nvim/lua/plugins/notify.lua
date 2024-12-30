return {
  {
    'rcarriga/nvim-notify',
    keys = {
      { '<Leader>nth', function() require("notify").history() end, desc = "Notification History", noremap = true }
    },
    config = function()
      vim.opt.termguicolors = true
      vim.notify = require("notify")
    end
  }
}
