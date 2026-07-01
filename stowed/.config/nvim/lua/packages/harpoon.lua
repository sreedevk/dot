return {
  'ThePrimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { "<leader>fa", function() require("harpoon.mark").add_file() end,        { desc = "Harpoon add file" } },
    { "<leader>fl", function() require("harpoon.ui").toggle_quick_menu() end, { desc = "Harpoon list files" } },
    { '<leader>1',        function() require("harpoon.ui").nav_file(1) end,         { desc = "Harpoon F1" } },
    { '<leader>2',        function() require("harpoon.ui").nav_file(2) end,         { desc = "Harpoon F2" } },
    { '<leader>3',        function() require("harpoon.ui").nav_file(3) end,         { desc = "Harpoon F3" } },
    { '<leader>4',        function() require("harpoon.ui").nav_file(4) end,         { desc = "Harpoon F4" } },
    { '<leader>5',        function() require("harpoon.ui").nav_file(5) end,         { desc = "Harpoon F5" } },
  },
}
