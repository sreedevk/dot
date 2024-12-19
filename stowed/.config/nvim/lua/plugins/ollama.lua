return {
  {
    "olimorris/codecompanion.nvim",
    lazy = true,
    keys = { "<Leader>ce" },
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
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = { adapter = "openai" },
          inline = { adapter = "ollama_llama_3_2" },
        },
        adapters = {
          openai = function()
            return require("codecompanion.adapters").extend("openai", {
              env = {
                api_key = "cmd:echo $OPENAI_API_KEY",
              },
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
      })

      vim.keymap.set(
        "v",
        "<Leader>ce",
        function() require("codecompanion").prompt("explain") end,
        { noremap = true, silent = true }
      )
    end
  }
}
