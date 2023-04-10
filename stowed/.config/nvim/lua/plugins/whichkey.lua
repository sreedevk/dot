return {
  "folke/which-key.nvim",
  config = function()
    local wk = require('which-key')
    vim.o.timeout = true
    vim.o.timeoutlen = 300

    local options = {
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "  ", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
      },
      popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
      },
      window = {
        border = "none", -- none/single/double/shadow
      },
      layout = {
        spacing = 6, -- spacing between columns
      },
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        i = { "j", "k" },
        v = { "j", "k" },
      },
      key_labels = {
        ["<space>"] = "SPC",
        ["<cr>"] = "RET",
        ["<tab>"] = "TAB"
      },
      ignore_missing = false,
      show_help = false,
    }

    local mappings = {
      ["<leader>"] = {
        g = {
          name = "+git",
          i = { "<cmd>Git<CR>", "git/status" },
          s = { "<cmd>Neotree git_status<CR>", "git/status(neotree)" },
          l = {
            name = "+git/log",
            g = { "<cmd>Git log --oneline --decorate --graph<CR>", "git/log(graph)" },
            o = { "<cmd>Git log<CR>", "git/log" }
          },
          p = {
            name = "+pull/push",
            u = { "<cmd>Git push<CR>", "git/push" },
            l = { "<cmd>Git pull<CR>", "git/pull" }
          }
        },
        t = {
          name = "+toggle",
          m = { "<cmd>TableModeToggle<CR>", "toggle/table"},
          f = { "<cmd>ToggleTerm direction=float<CR>", "toggle/terminal(f)" },
          r = { "<cmd>ToggleTerm<CR>", "toggle/terminal" },
          v = { "<cmd>ToggleVenn<CR>", "toggle/venn" },
          s = { "<cmd>set spell!<CR>", "toggle/spellcheck" },
          u = { "<cmd>UndotreeToggle<CR>", "toggle/undotree" },
          z = { "<cmd>ZenMode<CR>", "toggle/zenmode" }
        },
        r = {
          name = "+cmd",
          n = { "<cmd>CmdRun<CR>", "cmd/run" },
          s = { ":'>ToggleTermSendVisualLine<CR>", "cmd/send" }
        },
        b = {
          name = "+buffer",
          b = { "<cmd>bnext<CR>", "buffer/next" },
          B = { "<cmd>bprev<CR>", "buffer/prev" },
          l = { "<cmd>Telescope buffers<CR>", "buffer/list" },
          d = { "<cmd>bd<CR>", "buffer/delete" }
        }
      }
    }
    wk.register(mappings)
    wk.setup(options)
  end
}
