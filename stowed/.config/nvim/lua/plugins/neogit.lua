return {
  "NeogitOrg/neogit",
  lazy = true,
  cmd = { "Neogit" },
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
