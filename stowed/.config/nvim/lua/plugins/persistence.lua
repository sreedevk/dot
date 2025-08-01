return {
  "folke/persistence.nvim",
  lazy = true,
  event = "BufReadPre",
  keys = {
    { '<leader>sl', function() require("persistence").load({ last = true }) end, desc = "Load Last Session" },
    { '<leader>so', function() require("persistence").load() end,                desc = "Load Session For Current Directory" },
    { '<leader>sd', function() require("persistence").stop() end,                desc = "Don't Save Session on Exit" },
  },
  opts = {
    dir = vim.fn.stdpath("state") .. "/sessions/",
    need = 1,
    branch = true
  },
  module = "persistence",
  init = function()
    local group = vim.api.nvim_create_augroup('PersistenceSession', { clear = true })
    vim.api.nvim_create_autocmd("User", {
      group = group,
      pattern = "PersistenceSavePre",
      callback = wrap_cmd("Neotree close")
    })
  end,
}
