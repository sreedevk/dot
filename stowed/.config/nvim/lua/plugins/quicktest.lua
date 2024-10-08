return {
  "quolpr/quicktest.nvim",
  config = function()
    local qt = require("quicktest")

    local ruby = require("rubytest")

    qt.setup({
      -- Choose your adapter, here all supported adapters are listed
      adapters = {
        ruby,

        require("quicktest.adapters.golang")({
          additional_args = function(bufnr)
            return { "-race", "-count=1" }
          end,
          -- bin = function(bufnr) return 'go' end
          -- cwd = function(bufnr) return 'your-cwd' end
        }),
        require("quicktest.adapters.vitest")({
          -- bin = function(bufnr) return 'vitest' end
          -- cwd = function(bufnr) return bufnr end
          -- config_path = function(bufnr) return 'vitest.config.js' end
        }),
        require("quicktest.adapters.playwright")({
          -- bin = function(bufnr) return 'playwright' end
          -- cwd = function(bufnr) return bufnr end
          -- config_path = function(bufnr) return 'playwright.config.js' end
        }),
        require("quicktest.adapters.elixir"),
        require("quicktest.adapters.criterion"),
        require("quicktest.adapters.dart"),
      },
      -- split or popup mode, when argument not specified
      default_win_mode = "split",
      -- Baleia make coloured output. Requires baleia package. Can cause crashes https://github.com/quolpr/quicktest.nvim/issues/11
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
      "<leader>qt",
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
