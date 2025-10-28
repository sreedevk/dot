local wrap_cmd = require('core.utils').wrap_cmd

return {
  'nvim-telescope/telescope.nvim',
  lazy = true,
  dependencies = {
    "nvim-telescope/telescope-live-grep-args.nvim",
    'crispgm/telescope-heading.nvim',
    'j-hui/fidget.nvim',
    'jvgrootveld/telescope-zoxide',
    'nvim-telescope/telescope-frecency.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-symbols.nvim',
    'nvim-treesitter/nvim-treesitter',
    'davidgranstrom/telescope-scdoc.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  cmd = "Telescope",
  keys = {
    { '<C-p>',      require('telescope.builtin').find_files,                desc = 'Find Files',                   noremap = true },
    { '<C-s>',      wrap_cmd('Telescope'),                                  desc = 'Telescope',                    noremap = true },
    { "<Leader>bl", require('telescope.builtin').buffers,                   desc = 'Buffer List',                  noremap = true },
    { '<Leader>ft', require('telescope.builtin').filetypes,                 desc = 'Filetypes List',               noremap = true },
    { '<leader>fh', require('telescope.builtin').help_tags,                 desc = 'Help Tags List',               noremap = true },
    { '<leader>gc', require('telescope.builtin').git_commits,               desc = 'Git Commit List',              noremap = true },
    { '<Leader>/',  require('telescope.builtin').current_buffer_fuzzy_find, desc = 'Current Buff Fuzzy Find',      noremap = true },
    { '<Leader>cc', require('telescope.builtin').commands,                  desc = 'Commands List',                noremap = true },
    { "<Leader>'",  require('telescope.builtin').marks,                     desc = 'Marks List',                   noremap = true },
    { "<Leader>sp", require('telescope.builtin').spell_suggest,             desc = 'Suggest Spellings',            noremap = true },
    { "<Leader>tr", wrap_cmd("Telescope resume"),                           desc = "Resume Last Telescope Search", noremap = true },
    { '<Leader>zi', wrap_cmd("Telescope zoxide list"),                      desc = "Zoxide Interactive",           noremap = true },
    { '<Leader>th', wrap_cmd("Telescope heading"),                          desc = "Telescope Markdown Headings",  noremap = true },
    { '<Leader>lf', wrap_cmd("Telescope frecency"),                         desc = "Telescope Frecency",           noremap = true },
    {
      '<Leader>rg',
      function()
        require('telescope').extensions.live_grep_args.live_grep_args()
      end,
      desc = 'Live Grep',
      noremap = true,
    },
    {
      "<C-S-P>",
      function()
        require 'telescope.builtin'.find_files {
          prompt_title = "All Files",
          find_command = {
            "fd",
            "--type", "f",
            "--strip-cwd-prefix",
            "--hidden",
            "--follow",
            "--no-ignore-vcs",
            "--exclude", ".git",
            "--exclude", ".jj",
            "--exclude", "node_modules",
          }
        }
      end,
      desc = "Find Files (incl. Hidden)",
      noremap = true
    },
    {
      "<Leader>ej",
      function()
        require 'telescope.builtin'.symbols {
          sources = {
            'emoji',
            'kaomoji',
            'gitmoji',
          },
        }
      end,
      desc = 'Emojis',
    },
    {
      '<Leader>fp',
      function()
        require('telescope.builtin').find_files { cwd = vim.g.dotfiles }
      end,
      desc = 'Find Config Files'
    },
    {
      '<Leader>fw',
      function()
        require('telescope.builtin').grep_string({
          search = vim.fn.expand('<cword>'),
        })
      end,
      desc = 'Find CWord'
    },
  },
  config = function()
    local t_actions = require("telescope.actions")
    local lga_actions = require("telescope-live-grep-args.actions")
    require("telescope").setup({
      pickers = {
        live_grep = {
          theme = "ivy",
        },
        buffers = {
          theme = "ivy",
          sort_mru = true,
          ignore_current_buffer = true,
          mappings = {
            i = {
              ["<C-w>"] = "delete_buffer",
            },
            n = {
              ["<C-w>"] = "delete_buffer",
            },
          },
        },
        find_files = {
          theme = "ivy",
          find_command = {
            "fd",
            "--ignore-vcs",
            "--type", "f",
            "--hidden",
            "--glob",
            "--strip-cwd-prefix",
            "--exclude", ".git",
            "--exclude", ".jj",
            "--exclude", "*.age",
            "--exclude", "node_modules",
          }
        }
      },
      defaults = {
        file_ignore_patterns = { "dune.lock" },
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--ignore-vcs',
          '--hidden',
          '--glob', "!**/.git/*",
          '--glob', "!**/.jj/*",
          '--glob', "!**/node_modules/*",
        },
        extensions = {
          live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            mappings = {         -- extend mappings
              ["<C-e>"] = lga_actions.to_fuzzy_refine,
            }
          },
          heading = {
            treesitter = false,
          },
          zoxide = {
            mappings = {
              default = {
                action = function(selection)
                  vim.cmd.tcd(selection.path)
                end
              },
            }
          },
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        },
        mappings = {
          n = {
            ["q"] = t_actions.close,
          },
          i = {
            ["<C-k>"] = t_actions.move_selection_previous,
            ["<C-j>"] = t_actions.move_selection_next,
            ["<esc>"] = t_actions.close,
          },
        }
      },
    })

    local function live_grep_quickfix()
      local qflist = vim.fn.getqflist()
      local files = {}
      for _, item in ipairs(qflist) do
        local path = vim.fn.bufname(item.bufnr)
        if path ~= "" then
          table.insert(files, path)
        end
      end
      if #files == 0 then
        vim.notify("Quickfix list is empty", vim.log.levels.WARN)
        return
      end
      require("telescope.builtin").live_grep({ search_dirs = files })
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "qf",
      callback = function()
        vim.keymap.set("n", "<leader>rg", live_grep_quickfix, {
          buffer = true,
          desc = "Live grep in quickfix files",
        })
      end,
    })

    local telscp = require('telescope')

    pcall(telscp.load_extension, 'fidget')
    pcall(telscp.load_extension, 'fzf')
    pcall(telscp.load_extension, 'zoxide')
    pcall(telscp.load_extension, 'heading')
    pcall(telscp.load_extension, 'live_grep_args')
    pcall(telscp.load_extension, 'scdoc')
    pcall(telscp.load_extension, 'frecency')
  end
}
