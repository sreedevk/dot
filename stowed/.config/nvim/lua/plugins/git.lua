return {
  {
    'akinsho/git-conflict.nvim',
    version = "*",
    config = true,
  },
  {
    "sindrets/diffview.nvim",
    lazy = true,
    cmd = {
      "DiffviewOpen",
      "DiffviewFileHistory",
      "DiffviewFocusFiles",
      "DiffviewToggleFiles",
      "DiffviewRefresh",
    },
    keys = {
      { "<Leader>do", ":DiffviewOpen",                  desc = "Open Diffview" },
      { "<Leader>dc", "<cmd>DiffviewClose<CR>",         desc = "Close Diffview" },
      { "<Leader>dh", "<cmd>DiffviewFileHistory %<CR>", desc = "View Diffview File History" },
    },
  },
  {
    'tpope/vim-fugitive',
    lazy = true,
    cmd = "Git",
    keys = {
      { '<Leader>gb', [[<cmd>Git blame<CR>]],   desc = "Git Blame" },
      { '<Leader>gr', [[:Git rebase -i HEAD~]], desc = "Git Rebase" }
    },
  },

  {
    "NeogitOrg/neogit",
    lazy = true,
    cmd = { "Neogit" },
    keys = {
      { "<Leader>gi", "<cmd>Neogit<CR>", desc = "Neogit Dashboard" }
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      disable_hint = true,
      graph_style = "unicode",
      process_spinner = false,
      git_services = {
        ["github.com"]       = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
        ["bitbucket.org"]    = "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1",
        ["gitlab.com"]       = "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
        ["azure.com"]        = "https://dev.azure.com/${owner}/_git/${repository}/pullrequestcreate?sourceRef=${branch_name}&targetRef=${target}",
        ["gitea.nullptr.sh"] = "https://gitea.nullptr.sh/${owner}/${repository}/compare/${branch_name}",
      },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    config = true,
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")
        local mapping_opts = { noremap = true, buffer = bufnr }

        vim.keymap.set('n', '<Leader>sh', gitsigns.stage_hunk, mapping_opts)
        vim.keymap.set('v', '<leader>sh', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, mapping_opts)
        vim.keymap.set('n', '<leader>tb', gitsigns.toggle_current_line_blame, mapping_opts)
        vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end
    },
  }

}
