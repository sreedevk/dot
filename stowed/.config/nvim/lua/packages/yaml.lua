vim.api.nvim_create_autocmd({ "BufEnter", "CursorMoved" }, {
  pattern = { "*.yaml", "*.yml" },
  callback = function()
    vim.opt_local.winbar = require("yaml_nvim").get_yaml_key()
  end,
})

return {
  "https://tangled.org/cuducos.me/yaml.nvim",
  lazy = true,
  ft = {
    "yaml",
  },
  opts = {
    ft = {
      "yaml",
    }
  },
  keys = {
    { "<leader>yat", "<cmd>YAMLTelescope<cr>", desc = "YAML Telescope" },
  },
  cmd = {
    "YAMLView",
    "YAMLYank",
    "YAMLYankKey",
    "YAMLYankValue",
    "YAMLQuickfix",
    "YAMLTelescope"
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim"
  },
}
