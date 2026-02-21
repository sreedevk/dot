return {
  "https://tangled.org/cuducos.me/yaml.nvim",
  lazy = true,
  ft = {
    "yaml",
    "yaml.docker-compose",
  },
  opts = {
    ft = {
      "yaml",
      "yaml.docker-compose",
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
