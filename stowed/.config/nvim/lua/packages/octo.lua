return {
  "pwntester/octo.nvim",
  lazy = true,
  cmd = "Octo",
  opts = {
    picker = "telescope",
    enable_builtin = true,
  },
  keys = {
    {
      "<leader>oi",
      "<cmd>Octo issue list<cr>",
      desc = "List GitHub Issues",
    },
    {
      "<leader>or",
      "<cmd>Octo pr list<cr>",
      desc = "List GitHub PullRequests",
    },
    {
      "<leader>od",
      "<CMD>Octo discussion list<CR>",
      desc = "List GitHub Discussions",
    },
    {
      "<leader>on",
      "<cmd>Octo notification list<cr>",
      desc = "List GitHub Notifications",
    },
    {
      "<leader>os",
      function()
        require("octo.utils").create_base_search_command { include_current_repo = true }
      end,
      desc = "Search GitHub",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
}
