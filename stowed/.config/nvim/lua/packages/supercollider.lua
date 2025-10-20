return {
  {
    'davidgranstrom/scnvim',
    lazy = true,
    dependencies = { "davidgranstrom/telescope-scdoc.nvim" },
    cmd = {
      "SCNvimGenerateAssets",
      "SCNvimStart",
      "SCNvimStatusLine",
      "SCNvimStatusLine",
      "SCNvimTags",
      "SCNvimExt",
      "SCNvimRecompile",
      "SCNvimHelp",
    },
    ft = { 'supercollider' },
    config = function()
      local scnvim = require 'scnvim'
      local map = scnvim.map
      local map_expr = scnvim.map_expr

      scnvim.setup({
        keymaps = {
          ['<M-CR>'] = {
            map('editor.send_block', { 'i', 'n' }),
            map('editor.send_selection', 'x'),
          },
          ['<M-e>'] = map('postwin.toggle', { 'i', 'n' }),
          ['<M-L>'] = map('postwin.clear', { 'n', 'i' }),

          ['<leader>sck'] = map('signature.show', { 'n', 'i' }),

          ['<leader>scx'] = map('sclang.hard_stop', { 'n', 'x', 'i' }),
          ['<leader>scs'] = map('sclang.start'),
          ['<leader>scr'] = map('sclang.recompile'),

          ['<leader>scb'] = map_expr('s.boot'),
          ['<leader>scm'] = map_expr('s.meter'),
          ['<leader>sco'] = map_expr('s.scope'),
        },
        editor = {
          highlight = {
            color = 'IncSearch',
          },
        },
        postwin = {
          float = {
            enabled = true,
          },
        },
      })
    end
  }
}
