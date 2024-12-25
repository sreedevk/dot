return {
  'kevinhwang91/nvim-hlslens',
  lazy = true,
  event = { "BufReadPost", "BufAdd", "BufNewFile" },
  config = function()
    require('hlslens').setup()

    local kopts = { noremap = true, silent = true }
    vim.keymap.set('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
      kopts)
    vim.keymap.set('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
      kopts)
    vim.keymap.set('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.keymap.set('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.keymap.set('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.keymap.set('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

    vim.keymap.set({ 'n', 'x' }, '<Leader>L', function()
      vim.schedule(function()
        if require('hlslens').exportLastSearchToQuickfix() then
          vim.cmd('cw')
        end
      end)
      return ':noh<CR>'
    end, { expr = true })
  end
}
