return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
      "MeanderingProgrammer/render-markdown.nvim",
    },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = { adapter = "ollama" },
          inline = { adapter = "ollama" },
        },
        adapters = {
          ollama = function()
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

      vim.api.nvim_set_keymap("v", "<Leader>ce", "", {
        callback = function()
          require("codecompanion").prompt("explain")
        end,
        noremap = true,
        silent = true,
      })
    end
  }
}
