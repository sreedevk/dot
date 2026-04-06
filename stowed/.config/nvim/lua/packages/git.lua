return {
  {
    'akinsho/git-conflict.nvim',
    version = "*",
    config = true,
    opts = {
      -- co — choose ours
      -- ct — choose theirs
      -- cb — choose both
      -- c0 — choose none
      -- ]x — move to previous conflict
      -- [x — move to next conflict
      default_mappings = true,
      default_commands = true,
      disable_diagnostics = false,
      list_opener = 'copen',
      highlights = {
        incoming = 'DiffAdd',
        current = 'DiffText',
      }
    }
  },
  {
    "sindrets/diffview.nvim",
    lazy = true,
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewFileHistory",
      "DiffviewFocusFiles",
      "DiffviewToggleFiles",
      "DiffviewRefresh",
    },
    keys = {
      { "<Leader>gdo", ":DiffviewOpen",                  desc = "Open Diffview" },
      { "<Leader>gdc", "<cmd>DiffviewClose<CR>",         desc = "Close Diffview" },
      { "<Leader>gdh", "<cmd>DiffviewFileHistory %<CR>", desc = "View Diffview File History" },
    },
  },
  {
    'tpope/vim-fugitive',
    lazy = true,
    cmd = "Git",
    keys = {
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
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")
        local mapping_opts = function(desc)
          return { noremap = true, buffer = bufnr, desc = desc }
        end

        vim.keymap.set('n', '<Leader>ghs', gitsigns.stage_hunk, mapping_opts("Git Stage Hunk (N)"))
        vim.keymap.set('v', '<leader>ghs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
          mapping_opts("Git Stage Hunk (V)"))
        vim.keymap.set('n', '<Leader>ghR', gitsigns.reset_buffer, mapping_opts("Git Reset Buffer"))
        vim.keymap.set('n', "<leader>ghd", gitsigns.diffthis, mapping_opts("Git Diff This."))
        vim.keymap.set('n', "<leader>ghp", gitsigns.preview_hunk_inline, mapping_opts("Git Preview Hunk Inline"))
        vim.keymap.set('n', '<leader>ghB', gitsigns.toggle_current_line_blame,
          mapping_opts("Git Toggle Current Line Blame"))
        vim.keymap.set('n', '<leader>ghb', gitsigns.blame_line, mapping_opts("Git Blame Line"))
        vim.keymap.set('n', '<leader>gb', gitsigns.blame, mapping_opts("Git Blame Buffer"))
        vim.keymap.set('n', '<leader>ghD', function() gitsigns.diffthis("~") end, mapping_opts("Git Diff This ~"))
        vim.keymap.set({ 'o', 'x' }, 'ih', ':Gitsigns select_hunk<CR>', mapping_opts("Git Select Hunk"))
        vim.keymap.set('n', ']H', function() gitsigns.nav_hunk("last") end, mapping_opts("Git First Hunk"))
        vim.keymap.set('n', '[H', function() gitsigns.nav_hunk("first") end, mapping_opts("Git Last Hunk"))
        vim.keymap.set('n', ']h', function() gitsigns.nav_hunk("prev") end, mapping_opts("Git First Hunk"))
        vim.keymap.set('n', '[h', function() gitsigns.nav_hunk("next") end, mapping_opts("Git Last Hunk"))
      end
    },
  },
}
