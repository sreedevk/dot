return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    lazy = true,
    cmd = { "IBLDisableScope", "IBLDisable", "IBLEnable", "IBLEnableScope", "IBLToggle", "IBLToggleScope" },
    keys = {
      { "<Leader>ig", "<cmd>IBLToggle<cr>", desc = "Toggle Indent Guides", noremap = true }
    },
    opts = {
      enabled = false,
      indent = {
        highlight = {
          "CursorColumn",
          "Whitespace"
        },
        char = "",
      },
      whitespace = {
        highlight = {
          "CursorColumn",
          "Whitespace"
        },
        remove_blankline_trail = false
      },
      scope = {
        enabled = false,
      },
    },
  },
}
