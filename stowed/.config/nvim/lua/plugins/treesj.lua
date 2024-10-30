return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  keys = { '<leader>j' },
  config = function()
    require('treesj').setup({
      use_default_keymaps = false,
      check_syntax_error = true,
      max_join_length = 512,
      cursor_behavior = 'hold',
      notify = false,
      dot_repeat = true,
      on_error = nil,
    })

    vim.api.nvim_set_keymap('n', '<leader>j', [[<cmd>TSJToggle<cr>]], { noremap = true })
  end,
}
