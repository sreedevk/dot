return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
      's1n7ax/nvim-window-picker'
    },
    keys = {
      { "<C-n>",     [[<cmd>Neotree filesystem reveal toggle<CR>]], desc = "Toggle Neotree" },
      { "<Leader>n", [[<cmd>Neotree reveal<CR>]],                   desc = "Reveal File in Neotree" },
    },
    lazy = true,
    config = function()
      vim.g.neo_tree_remove_legacy_commands = 1

      require('neo-tree').setup({
        close_if_last_window = true,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = false,
        sort_case_insensitive = false,
        sort_function = nil,

        open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
        default_component_configs = {
          container = { enable_character_fade = true },
          indent = {
            indent_size = 2,
            padding = 1,
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            with_expanders = nil,
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
            highlight = "NeoTreeIndentMarker"
          },
          icon = {
            folder_closed = " ",
            folder_open = " ",
            folder_empty = "🖿 ",
            default = "*",
            highlight = "NeoTreeFileIcon"
          },
          modified = {
            symbol = "[+]",
            highlight = "NeoTreeModified",
          },
          file_size = {
            enabled = true,
            width = 12,
            required_width = 64,
          },
          type = {
            enabled = true,
            width = 10,
            required_width = 122,
          },
          last_modified = {
            enabled = true,
            width = 20,
            required_width = 88,
          },
          created = {
            enabled = true,
            width = 20,
            required_width = 110,
          },
          symlink_target = {
            enabled = false,
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
          },
          git_status = {
            symbols = {
              added     = "+",
              modified  = "~",
              deleted   = "x",
              renamed   = "R",
              untracked = "?",
              ignored   = "/",
              unstaged  = "",
              staged    = "",
              conflict  = "",
            }
          },
        },
        window = {
          position = "left",
          width = 30,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ["<space>"] = { "toggle_node", nowait = true, },
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["<esc>"] = "revert_preview",
            ["P"] = { "toggle_preview", config = { use_float = true } },
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            ["T"] = "open_tabnew",
            ["w"] = "open_with_window_picker",
            ["C"] = "close_node",
            ["z"] = "close_all_nodes",
            ["Z"] = "expand_all_nodes",
            ["a"] = {
              "add",
              config = {
                show_path = "relative"
              }
            },
            ["A"] = "add_directory",
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy",
            ["m"] = { "move", config = { show_path = "relative" } },
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
          }
        },
        nesting_rules = {},
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = true,
            hide_hidden = true,
            hide_by_name = {},
            hide_by_pattern = {},
            always_show = {},
            never_show = {},
            never_show_by_pattern = {},
          },
          follow_current_file = {
            enabled = false,
            leave_dirs_open = true
          },
          group_empty_dirs = false,
          hijack_netrw_behavior = "disabled",
          use_libuv_file_watcher = true,
          window = {
            mappings = {
              ["u"] = "navigate_up",
              ["."] = "set_root",
              ["I"] = "toggle_hidden",
              ["/"] = "fuzzy_finder",
              ["D"] = "fuzzy_finder_directory",
              ["#"] = "fuzzy_sorter",
              ["f"] = "filter_on_submit",
              ["<c-x>"] = "clear_filter",
              ["[g"] = "prev_git_modified",
              ["]g"] = "next_git_modified",
              ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
              ["oc"] = { "order_by_created", nowait = false },
              ["od"] = { "order_by_diagnostics", nowait = false },
              ["og"] = { "order_by_git_status", nowait = false },
              ["om"] = { "order_by_modified", nowait = false },
              ["on"] = { "order_by_name", nowait = false },
              ["os"] = { "order_by_size", nowait = false },
              ["ot"] = { "order_by_type", nowait = false },
            },
            fuzzy_finder_mappings = {
              ["<down>"] = "move_cursor_down",
              ["<C-M-j>"] = "move_cursor_down",
              ["<up>"] = "move_cursor_up",
              ["<C-M-k>"] = "move_cursor_up",
            },
          }
        },
        buffers = {
          follow_current_file = {
            enabled = false,
            leave_dirs_open = true
          },
          group_empty_dirs = true,
          show_unloaded = true,
          window = {
            mappings = {
              ["bd"] = "buffer_delete",
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
              ["oc"] = { "order_by_created", nowait = false },
              ["od"] = { "order_by_diagnostics", nowait = false },
              ["om"] = { "order_by_modified", nowait = false },
              ["on"] = { "order_by_name", nowait = false },
              ["os"] = { "order_by_size", nowait = false },
              ["ot"] = { "order_by_type", nowait = false },
            }
          },
        },
        git_status = {
          window = {
            position = "float",
            mappings = {
              ["A"] = "git_add_all",
              ["gu"] = "git_unstage_file",
              ["ga"] = "git_add_file",
              ["gr"] = "git_revert_file",
              ["gc"] = "git_commit",
              ["gp"] = "git_push",
              ["gg"] = "git_commit_and_push",
              ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
              ["oc"] = { "order_by_created", nowait = false },
              ["od"] = { "order_by_diagnostics", nowait = false },
              ["om"] = { "order_by_modified", nowait = false },
              ["on"] = { "order_by_name", nowait = false },
              ["os"] = { "order_by_size", nowait = false },
              ["ot"] = { "order_by_type", nowait = false },
            }
          }
        }
      })
    end
  },
  {
    's1n7ax/nvim-window-picker',
    version = '2.*',
    config = function()
      require 'window-picker'.setup({
        filter_rules = {
          include_current_win = false,
          autoselect_one = true,
          bo = {
            filetype = { 'neo-tree', "neo-tree-popup", "notify" },
            buftype = { 'terminal', "quickfix" },
          },
        },
      })
    end,
  },
}
