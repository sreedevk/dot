return {
  "cuducos/yaml.nvim",
  lazy = true,
  ft = { "yaml" },
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
