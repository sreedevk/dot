return {
  "quolpr/quicktest.nvim",
  config = function()
    require("quicktest").setup({
      use_experimental_colorizer = true,
      adapters = {
        require("quicktest.adapters.rspec"),
        require("quicktest.adapters.elixir"),
        require("quicktest.adapters.golang")({
          additional_args = function(_) return { "-race", "-count=1" } end,
        })
      },
      default_win_mode = "split",
      use_baleia = false,
    })
  end,
  dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", "folke/trouble.nvim" },
  keys = {
    { "<leader>tl", function() require("quicktest").run_line() end,           desc = "[T]est Run [L]line" },
    { "<leader>tf", function() require("quicktest").run_file() end,           desc = "[T]est Run [F]ile" },
    { "<leader>td", function() require("quicktest").run_dir() end,            desc = "[T]est Run [D]ir" },
    { "<leader>ta", function() require("quicktest").run_all() end,            desc = "[T]est Run [A]ll" },
    { "<leader>tp", function() require("quicktest").run_previous() end,       desc = "[T]est Run [P]revious" },
    { "<leader>tw", function() require("quicktest").toggle_win("split") end,  desc = "[T]est Toggle [W]indow" },
    { "<leader>tc", function() require("quicktest").cancel_current_run() end, desc = "[T]est [C]ancel Current Run" },
  },
}
