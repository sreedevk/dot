return {
  {
    "olimorris/codecompanion.nvim",
    lazy = true,
    keys = {
      {
        "<Leader>ce",
        function()
          require("codecompanion").prompt("explain")
        end,
        mode = "v",
        desc = "Describe Code (Ask GPT)",
        noremap = true,
        silent = true,
      }
    },
    cmd = {
      "CodeCompanion",
      "CodeCompanionActions",
      "CodeCompanionChat",
      "CodeCompanionCmd",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
      "MeanderingProgrammer/render-markdown.nvim",
    },
    opts = {
      strategies = {
        chat = { adapter = "openai" },
        inline = { adapter = "ollama" },
      },
      adapters = {
        opts = {
          show_model_choices = true,
          show_defaults = true,
        },
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            env = {
              api_key = "cmd:echo $OPENAI_API_KEY",
              schema = {
                model = { default = "o4-mini" }
              }
            },
          })
        end,
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = { default = "deepseek-r1:14b" },
            },
            env = { url = "http://127.0.0.1:11434" },
            parameters = { sync = true, },
          })
        end,
      },
    },
  }
}
