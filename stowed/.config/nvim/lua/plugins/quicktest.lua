return {
  "quolpr/quicktest.nvim",
  config = function()
    local qt = require("quicktest")
    local ruby = require("rubytest")

    qt.setup({
      adapters = {
        ruby,
        require("quicktest.adapters.golang")({
          additional_args = function(bufnr)
            return { "-race", "-count=1" }
          end,
        }),
        require("quicktest.adapters.vitest")({}),
        require("quicktest.adapters.playwright")({}),
        require("quicktest.adapters.elixir"),
        require("quicktest.adapters.criterion"),
        require("quicktest.adapters.dart"),
      },
      default_win_mode = "split",
      use_baleia = false,
    })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "folke/trouble.nvim"
  },
  keys = {
    {
      "<leader>tl",
      function()
        local qt = require("quicktest")
        qt.run_line()
      end,
      desc = "[T]est Run [L]line",
    },
    {
      "<leader>tf",
      function()
        local qt = require("quicktest")

        qt.run_file()
      end,
      desc = "[T]est Run [F]ile",
    },
    {
      "<leader>td",
      function()
        local qt = require("quicktest")

        qt.run_dir()
      end,
      desc = "[T]est Run [D]ir",
    },
    {
      "<leader>ta",
      function()
        local qt = require("quicktest")

        qt.run_all()
      end,
      desc = "[T]est Run [A]ll",
    },
    {
      "<leader>tp",
      function()
        local qt = require("quicktest")

        qt.run_previous()
      end,
      desc = "[T]est Run [P]revious",
    },
    {
      "<leader>tw",
      function()
        local qt = require("quicktest")

        qt.toggle_win("split")
      end,
      desc = "[T]est [T]oggle Window",
    },
    {
      "<leader>tc",
      function()
        local qt = require("quicktest")

        qt.cancel_current_run()
      end,
      desc = "[T]est [C]ancel Current Run",
    },
  },
}
