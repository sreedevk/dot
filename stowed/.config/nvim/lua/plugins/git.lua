return {
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
      "<Leader>do",
      "<Leader>dc",
      "<Leader>dh",
    },
    config = function()
      vim.keymap.set('n', '<Leader>do', ":DiffviewOpen ", { noremap = true })
      vim.keymap.set('n', '<Leader>dc', "<cmd>DiffviewClose<CR>", { noremap = true })
      vim.keymap.set('n', '<Leader>dh', "<cmd>DiffviewFileHistory %<CR>", { noremap = true })
    end
  },
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<Leader>gb', [[<cmd>Git blame<CR>]], { noremap = true })
      vim.keymap.set('n', '<Leader>gr', [[:Git rebase -i HEAD~]], { noremap = true })
    end
  },

  {
    "NeogitOrg/neogit",
    lazy = true,
    cmd = { "Neogit" },
    keys = { "<Leader>gi" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      vim.keymap.set('n', '<Leader>gi', "<cmd>Neogit<CR>", { noremap = true })

      local neogit = require("neogit")
      neogit.setup({
        disable_hint = true,
        graph_style = "unicode",
        process_spinner = false,
        git_services = {
          ["github.com"] = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
          ["bitbucket.org"] = "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1",
          ["gitlab.com"] =
          "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
          ["azure.com"] =
          "https://dev.azure.com/${owner}/_git/${repository}/pullrequestcreate?sourceRef=${branch_name}&targetRef=${target}",
          ["gitea.nullptr.sh"] = "https://gitea.nullptr.sh/${owner}/${repository}/compare/${branch_name}",
        },
      })
    end
  }
}
