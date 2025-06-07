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
        inline = { adapter = "ollama_llama_3_2" },
        -- chat = { adapter = "ollama_gemma_3_4b" },
        -- inline = { adapter = "ollama_llama_3_2" },
      },
      adapters = {
        opts = {
          show_model_choices = true,
          show_defaults = true,
        },
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            env = {
              -- TODO: change cmd to read api_key from agenix file
              api_key = "cmd:echo $OPENAI_API_KEY",
              schema = {
                model = {
                  default = "gpt-4o",
                  num_ctx = { default = 16384 },
                  num_predict = { default = -1 },
                }
              }
            },
          })
        end,
        ollama_gemma_3_4b = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "gemma3_12b",
            schema = {
              model = { default = "gemma3:12b" },
              num_ctx = { default = 16384 },
              num_predict = { default = -1 },
            },
            env = { url = "http://127.0.0.1:11434" },
            headers = { ["Content-Type"] = "application/json" },
            parameters = { sync = true, },
          })
        end,
        ollama_llama_3_2 = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "llama3.2",
            schema = {
              model = { default = "llama3.2" },
              num_ctx = { default = 16384 },
              num_predict = { default = -1 },
            },
            env = { url = "https://ai.nullptr.sh" },
            headers = { ["Content-Type"] = "application/json" },
            parameters = { sync = true, },
          })
        end,
      },
    },
  }
}
