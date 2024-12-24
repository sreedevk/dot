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
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
}
