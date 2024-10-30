return {
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
    "<Leader>dvo",
    "<Leader>dvc",
    "<Leader>dvh",
  },
  config = function()
    vim.api.nvim_set_keymap('n', '<Leader>dvo', ":DiffviewOpen ", { noremap = true })
    vim.api.nvim_set_keymap('n', '<Leader>dvc', "<cmd>DiffviewClose<CR>", { noremap = true })
    vim.api.nvim_set_keymap('n', '<Leader>dvh', "<cmd>DiffviewFileHistory %<CR>", { noremap = true })
  end
}
