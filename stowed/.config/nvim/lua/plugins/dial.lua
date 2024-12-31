return {
  {
    'monaqa/dial.nvim',
    lazy = true,
    keys = {
      { '<C-a>',  '<Plug>(dial-increment)',  mode = 'n' },
      { '<C-x>',  '<Plug>(dial-decrement)',  mode = 'n' },
      { '<C-a>',  '<Plug>(dial-increment)',  mode = 'v' },
      { '<C-x>',  '<Plug>(dial-decrement)',  mode = 'v' },
      { 'g<C-a>', 'g<Plug>(dial-increment)', mode = 'v' },
      { 'g<C-x>', 'g<Plug>(dial-decrement)', mode = 'v' },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group {
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
        },
        mygroup = {
          augend.integer.alias.decimal,
          augend.constant.alias.bool,
          augend.date.alias["%m/%d/%Y"],
        }
      }
    end,
  }
}
