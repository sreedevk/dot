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
      display = {
        action_palette = {
          width = 95,
          height = 10,
          prompt = "Prompt ",
          provider = "default",
          opts = {
            show_default_actions = true,
            show_default_prompt_library = true,
          },
        },
      },
      strategies = {
        chat = {
          adapter = {
            name = "ollama",
            model = "deepseek-coder-v2:16b"
          },
        },
        inline = {
          adapter = {
            name = "ollama",
            model = "deepseek-coder-v2:16b",
          },
        },
        cmd = {
          adapter = {
            name = "ollama",
            adapter = "deepseek-coder-v2:16b"
          },
        }
      },
      adapters = {
        opts = {
          show_model_choices = true,
          show_defaults = true,
        },
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            schema = {
              model = { default = "gpt-4o" }
            },
            env = {
              api_key = "cmd:echo $OPENAI_API_KEY",
            },
          })
        end,
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = { default = "deepseek-coder-v2:16b" },
            },
            env = { url = "http://127.0.0.1:11434" },
            parameters = { sync = true, },
          })
        end,
      },
    },
  }
}
