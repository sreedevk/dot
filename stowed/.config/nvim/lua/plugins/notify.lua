return {
  {
    'rcarriga/nvim-notify',
    keys = {
      { '<Leader>nth', function() require("notify").history() end, desc = "Notification History", noremap = true },
      {
        '<leader>nd',
        function()
          require("notify").dismiss({
            silent = true,
            pending = true,
          })
        end,
        desc = 'dismiss notifications',
        noremap = true,
      }
    },
    config = function()
      vim.opt.termguicolors = true
      vim.notify = require("notify")
    end
  }
}
