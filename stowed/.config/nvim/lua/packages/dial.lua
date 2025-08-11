local inc_norm = function() require("dial.map").manipulate("increment", "normal") end
local dec_norm = function() require("dial.map").manipulate("decrement", "normal") end
local inc_vis = function() require("dial.map").manipulate("increment", "visual") end
local dec_vis = function() require("dial.map").manipulate("decrement", "visual") end
local inc_gvis = function() require("dial.map").manipulate("increment", "gvisual") end
local dec_gvis = function() require("dial.map").manipulate("decrement", "gvisual") end

-- TODO: Add a custom dial for ledger type files to switch between * and ! for transaction status
return {
  {
    'monaqa/dial.nvim',
    lazy = true,
    keys = {
      { '<C-a>',  inc_norm, mode = 'n', noremap = true },
      { '<C-x>',  dec_norm, mode = 'n', noremap = true },
      { '<C-a>',  inc_vis,  mode = 'v', noremap = true },
      { '<C-x>',  dec_vis,  mode = 'v', noremap = true },
      { 'g<C-a>', inc_gvis, mode = 'v', noremap = true },
      { 'g<C-x>', dec_gvis, mode = 'v', noremap = true },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group {
        default = {
          augend.constant.alias.Alpha,
          augend.constant.alias.alpha,
          augend.constant.alias.bool,
          augend.date.alias["%Y-%m-%d"],
          augend.date.alias["%Y/%m/%d"],
          augend.integer.alias.binary,
          augend.integer.alias.decimal,
          augend.integer.alias.decimal_int,
          augend.integer.alias.hex,
          augend.integer.alias.octal,
          augend.semver.alias.semver,
        },
      }
    end,
  }
}
