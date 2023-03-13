return {
  "cuducos/yaml.nvim",
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
