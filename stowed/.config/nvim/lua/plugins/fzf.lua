return {
  {
    'ibhagwan/fzf-lua',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = true,
    keys = {
      { "<C-p>",      function() require('fzf-lua').files() end,        desc = "Find Files",     noremap = true },
      { "<C-s>",      "<cmd>FzfLua<CR>",                                desc = "Find Files",     noremap = true },
      { "<Leader>rg", function() require('fzf-lua').grep_project() end, desc = "Grep Files",     noremap = true },
      { "<Leader>bl", function() require('fzf-lua').buffers() end,      desc = "List Buffers",   noremap = true },
      { "<Leader>ft", function() require('fzf-lua').filetypes() end,    desc = "List Filetypes", noremap = true },
      { "<Leader>fh", function() require('fzf-lua').helptags() end,     desc = "List Filetypes", noremap = true },
      { "<Leader>gc", function() require('fzf-lua').git_commits() end,  desc = "List Filetypes", noremap = true },
      { "<Leader>/",  function() require('fzf-lua').lgrep_curbuf() end, desc = "List Filetypes", noremap = true },
      { "<Leader>fw", function() require('fzf-lua').grep_cWORD() end,   desc = "List Filetypes", noremap = true },
    },
    config = true,
    opts = {
      files = {
        prompt  = 'Files❯ ',
        rg_opts = [[--color=never --files  --follow --hidden --glob --ignore]],
        fd_opts = [[--color=never --type f --follow --hidden --exclude .git]],
      },
      grep = {
        prompt       = 'Rg❯ ',
        input_prompt = 'Grep❯ ',
        rg_opts      = [[--color=always --column --with-filename --line-number --hidden --no-heading --smart-case]],
        rg_glob      = true,
      },
    },
  }
}
