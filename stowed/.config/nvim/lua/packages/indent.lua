return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    lazy = true,
    event = "BufReadPost",
    cmd = {
      "IBLDisableScope",
      "IBLDisable",
      "IBLEnable",
      "IBLEnableScope",
      "IBLToggle",
      "IBLToggleScope",
    },
    keys = {
      {
        "<Leader>ig",
        "<cmd>IBLToggle<cr>",
        desc = "Toggle Indent Guides",
        noremap = true,
      }
    },
    opts = {
      enabled = true,
      indent = {
        char = { "┋" },
      },
      whitespace = {
        remove_blankline_trail = false
      },
      scope = {
        enabled = false,
      },
    },
  },
}
