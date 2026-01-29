-- Telescope Configuration

return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    cmd = "Telescope",
    keys = {
      -- File finding (git-aware like the original <leader>o)
      {
        "<leader>o",
        function()
          local builtin = require("telescope.builtin")
          local ok = pcall(builtin.git_files, { show_untracked = true })
          if not ok then
            builtin.find_files()
          end
        end,
        desc = "Find files (git-aware)",
      },
      { "<leader>sf", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>sg", "<cmd>Telescope git_files<CR>", desc = "Git files" },
      { "<leader>sG", "<cmd>Telescope git_status<CR>", desc = "Modified git files" },

      -- Grep (like original <leader><leader>f for Rg)
      { "<leader><leader>f", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
      { "<leader>ss", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
      { "<leader>sw", "<cmd>Telescope grep_string<CR>", desc = "Grep word under cursor" },

      -- Buffer search (like original BLines)
      { "<leader>sl", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Search current buffer" },
      { "<leader>b", "<cmd>Telescope buffers<CR>", desc = "Open buffers" },
      { "<leader>sb", "<cmd>Telescope buffers<CR>", desc = "Open buffers" },

      -- Search history and commands
      { "<leader>s/", "<cmd>Telescope search_history<CR>", desc = "Search history" },
      { "<leader>s;", "<cmd>Telescope commands<CR>", desc = "Commands" },
      { "<leader>sC", "<cmd>Telescope command_history<CR>", desc = "Command history" },
      { "<leader>sh", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },

      -- Git
      { "<leader>sc", "<cmd>Telescope git_commits<CR>", desc = "Git commits" },
      { "<leader>gv", "<cmd>Telescope git_commits<CR>", desc = "View commits" },
      { "<leader>gV", "<cmd>Telescope git_bcommits<CR>", desc = "View buffer commits" },

      -- LSP
      { "<leader>co", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Document symbols" },
      { "<leader>cs", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "Workspace symbols" },
      { "<leader>cI", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },

      -- Misc
      { "<leader>sm", "<cmd>Telescope marks<CR>", desc = "Marks" },
      { "<leader>sM", "<cmd>Telescope keymaps<CR>", desc = "Keymaps" },
      { "<leader>sp", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
      { "<leader>sP", "<cmd>Telescope man_pages<CR>", desc = "Man pages" },
      { "<leader>sS", "<cmd>Telescope colorscheme<CR>", desc = "Color schemes" },
      { "<leader>sy", "<cmd>Telescope filetypes<CR>", desc = "File types" },
      { "<leader>sr", "<cmd>Telescope resume<CR>", desc = "Resume last search" },

      -- Double leader mappings (preserving coc-style)
      { "<leader><leader>a", "<cmd>Telescope diagnostics<CR>", desc = "All diagnostics" },
      { "<leader><leader>o", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Document outline" },
      { "<leader><leader>s", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "Workspace symbols" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.4,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-c>"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            },
            n = {
              ["<esc>"] = actions.close,
              ["q"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["H"] = actions.move_to_top,
              ["M"] = actions.move_to_middle,
              ["L"] = actions.move_to_bottom,
              ["gg"] = actions.move_to_top,
              ["G"] = actions.move_to_bottom,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
            },
          },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            follow = true,
          },
          live_grep = {
            additional_args = function()
              return { "--hidden" }
            end,
          },
          buffers = {
            sort_lastused = true,
            mappings = {
              i = {
                ["<C-d>"] = actions.delete_buffer,
              },
              n = {
                ["d"] = actions.delete_buffer,
              },
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })

      -- Load extensions
      telescope.load_extension("fzf")
    end,
  },
}
