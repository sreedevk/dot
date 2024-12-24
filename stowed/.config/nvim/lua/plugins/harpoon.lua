return {
  "ThePrimeagen/harpoon",
  lazy = true,
  keys = {
    { "<Leader>fa", function() require("harpoon"):list():add() end,  desc = "Harpoon File Add" },
    { "<M-o>",      function() require("harpoon"):list():prev() end, desc = "Harpoon File Prev" },
    { "<M-i>",      function() require("harpoon"):list():next() end, desc = "Harpoon File Next" },
    {
      "<Leader>fl",
      function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end,
      desc = "Harpoon File List",
    },
  },
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = true,
}
