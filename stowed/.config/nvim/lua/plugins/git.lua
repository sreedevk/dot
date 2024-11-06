return {
  {
    "sindrets/diffview.nvim",
    lazy = true,
    cmd = {
      "DiffviewOpen",
      "DiffviewFileHistory",
      "DiffviewFocusFiles",
      "DiffviewToggleFiles",
      "DiffviewRefresh",
    },
    keys = {
      "<Leader>do",
      "<Leader>dc",
      "<Leader>dh",
    },
    config = function()
      vim.api.nvim_set_keymap('n', '<Leader>do', ":DiffviewOpen ", { noremap = true })
      vim.api.nvim_set_keymap('n', '<Leader>dc', "<cmd>DiffviewClose<CR>", { noremap = true })
      vim.api.nvim_set_keymap('n', '<Leader>dh', "<cmd>DiffviewFileHistory %<CR>", { noremap = true })
    end
  },
  {
    'tpope/vim-fugitive',
    config = function()
      vim.api.nvim_set_keymap('n', '<Leader>gb', [[<cmd>Git blame<CR>]], { noremap = true })
    end
  },

  {
    "NeogitOrg/neogit",
    lazy = true,
    cmd = { "Neogit" },
    keys = { "<Leader>gi" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
      "ibhagwan/fzf-lua",
    },
    config = function()
      vim.api.nvim_set_keymap('n', '<Leader>gi', "<cmd>Neogit<CR>", { noremap = true })

      return true
    end
  }
}
