return {
  'kevinhwang91/nvim-hlslens',
  lazy = true,
  event = { "BufReadPost", "BufAdd", "BufNewFile" },
  config = function()
    require('hlslens').setup()

    local function export_ls_to_qf()
      vim.schedule(function()
        if require('hlslens').exportLastSearchToQuickfix() then
          vim.cmd('cw')
        end
      end)
      return ':noh<CR>'
    end

    local kopts = { noremap = true, silent = true }
    vim.keymap.set('n', 'n', [[<cmd>execute('normal! ' . v:count1 . 'n')<cr><cmd>lua require('hlslens').start()<cr>]], kopts)
    vim.keymap.set('n', 'N', [[<cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<cr>]], kopts)
    vim.keymap.set('n', '*', [[*<cmd>lua require('hlslens').start()<cr>]], kopts)
    vim.keymap.set('n', '#', [[#<cmd>lua require('hlslens').start()<cr>]], kopts)
    vim.keymap.set('n', 'g*', [[g*<cmd>lua require('hlslens').start()<cr>]], kopts)
    vim.keymap.set('n', 'g#', [[g#<cmd>lua require('hlslens').start()<cr>]], kopts)
    vim.keymap.set({ 'n', 'x' }, '<Leader>L', export_ls_to_qf, { expr = true })
  end
}
