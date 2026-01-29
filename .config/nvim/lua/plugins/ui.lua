-- UI Configuration (lualine, alpha, neo-tree)

return {
  -- Lualine (replacement for vim-airline)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        icons_enabled = true,
        theme = "gruvbox",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "lazy" },
          winbar = {},
        },
        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          {
            "filename",
            file_status = true,
            path = 1, -- relative path
          },
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "fugitive", "lazy", "neo-tree", "toggleterm" },
    },
  },

  -- Neo-tree (replacement for rnvimr/coc-explorer)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "<C-e>", function() require("neo-tree.command").execute({ toggle = true }) end, desc = "Explorer" },
      { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Explorer" },
      { "<leader>E", "<cmd>Neotree reveal<CR>", desc = "Explorer (reveal)" },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      -- Open neo-tree on startup only when no file arguments
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if vim.fn.argc() == 0 then
            require("neo-tree.command").execute({ action = "show" })
          end
        end,
      })
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "qf" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      window = {
        width = 30,
        mappings = {
          ["<space>"] = "none",
          ["l"] = "open",
          ["h"] = "close_node",
          ["<cr>"] = "open",
          ["s"] = "open_split",
          ["v"] = "open_vsplit",
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        git_status = {
          symbols = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌",
          },
        },
      },
    },
  },

  -- Aerial (replacement for vista.vim)
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { "AerialToggle", "AerialOpen", "AerialNavToggle" },
    keys = {
      { "<leader>cv", "<cmd>AerialToggle!<CR>", desc = "Toggle outline" },
      { "<leader>so", "<cmd>AerialToggle!<CR>", desc = "Outline" },
    },
    opts = {
      attach_mode = "global",
      backends = { "lsp", "treesitter", "markdown", "man" },
      layout = {
        min_width = 28,
        default_direction = "prefer_right",
      },
      show_guides = true,
      filter_kind = false,
      guides = {
        mid_item = "├ ",
        last_item = "└ ",
        nested_top = "│ ",
        whitespace = "  ",
      },
      keymaps = {
        ["?"] = "actions.show_help",
        ["<CR>"] = "actions.jump",
        ["<C-v>"] = "actions.jump_vsplit",
        ["<C-s>"] = "actions.jump_split",
        ["p"] = "actions.scroll",
        ["<C-j>"] = "actions.down_and_scroll",
        ["<C-k>"] = "actions.up_and_scroll",
        ["{"] = "actions.prev",
        ["}"] = "actions.next",
        ["[["] = "actions.prev_up",
        ["]]"] = "actions.next_up",
        ["q"] = "actions.close",
        ["o"] = "actions.tree_toggle",
        ["l"] = "actions.tree_open",
        ["h"] = "actions.tree_close",
        ["zr"] = "actions.tree_increase_fold_level",
        ["zR"] = "actions.tree_open_all",
        ["zm"] = "actions.tree_decrease_fold_level",
        ["zM"] = "actions.tree_close_all",
        ["zx"] = "actions.tree_sync_folds",
      },
    },
  },

  -- Persistence (session management like startify sessions)
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
    },
    keys = {
      { "<leader>S", [[<cmd>lua require("persistence").load()<CR>]], desc = "Restore session" },
      { "<leader>qs", [[<cmd>lua require("persistence").load()<CR>]], desc = "Restore session" },
      { "<leader>ql", [[<cmd>lua require("persistence").load({ last = true })<CR>]], desc = "Restore last session" },
      { "<leader>qd", [[<cmd>lua require("persistence").stop()<CR>]], desc = "Don't save session" },
    },
  },

  -- Web devicons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
        },
      },
    },
  },
}
