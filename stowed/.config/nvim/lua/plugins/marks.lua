return {
  {
    'chentoast/marks.nvim',
    lazy = true,
    event = "BufReadPost",
    keys = {
      { '<leader>mm', '<Cmd>MarksListBuf<CR>',      desc = 'list buffer marks',  noremap = true },
      { '<leader>mg', '<Cmd>MarksQFListGlobal<CR>', desc = 'list global marks',  noremap = true },
      { '<leader>m0', '<Cmd>BookmarksQFList 0<CR>', desc = 'list bookmarks',     noremap = true },
    },
    opts = {
      force_write_shada = false,
      excluded_filetypes = { 'NeogitStatus', 'NeogitCommitMessage', 'toggleterm' },
      bookmark_0 = { sign = '⚑', virt_text = '' },
      mappings = { annotate = 'm?' },
    }
  }
}
