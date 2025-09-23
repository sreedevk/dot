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
        ["github.com"] = {
          pull_request = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
          commit = "https://github.com/${owner}/${repository}/commit/${oid}",
          tree = "https://${host}/${owner}/${repository}/tree/${branch_name}",
        },
        ["bitbucket.org"] = {
          pull_request = "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1",
          commit = "https://bitbucket.org/${owner}/${repository}/commits/${oid}",
          tree = "https://bitbucket.org/${owner}/${repository}/branch/${branch_name}",
        },
        ["gitlab.com"] = {
          pull_request =
          "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
          commit = "https://gitlab.com/${owner}/${repository}/-/commit/${oid}",
          tree = "https://gitlab.com/${owner}/${repository}/-/tree/${branch_name}?ref_type=heads",
        },
        ["gitea.nullptr.sh"] = {
          pull_request = "https://gitea.nullptr.sh/${owner}/${repository}/compare/${branch_name}",
          commit = "https://gitea.nullptr.sh/${owner}/${repository}/commit/${oid}",
          tree = "https://gitea.nullptr.sh/${owner}/${repository}/src/branch/${branch_name}"
        },
        ["git.devtechnica.com"] = {
          pull_request = "https://git.devtechnica.com/${owner}/${repository}/compare/${branch_name}",
          commit = "https://git.devtechnica.com/${owner}/${repository}/commit/${oid}",
          tree = "https://git.devtechnica.com/${owner}/${repository}/src/branch/${branch_name}"
        }
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
        vim.keymap.set('v', '<leader>sh', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
          mapping_opts)
        vim.keymap.set('n', '<leader>tb', gitsigns.toggle_current_line_blame, mapping_opts)
        vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end
    },
  }

}
