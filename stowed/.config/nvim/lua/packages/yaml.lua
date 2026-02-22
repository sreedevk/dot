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
