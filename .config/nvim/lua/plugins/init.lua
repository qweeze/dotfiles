-- Plugin specifications for lazy.nvim

return {
  -- Theme
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        bold = false,
        italic = {
          strings = false,
          comments = true,
          operators = false,
          folds = true,
        },
        contrast = "",
      })
      vim.cmd.colorscheme("gruvbox")
    end,
  },

  -- LSP
  { import = "plugins.lsp" },

  -- Completion
  { import = "plugins.completion" },

  -- Telescope
  { import = "plugins.telescope" },

  -- Treesitter
  { import = "plugins.treesitter" },

  -- Git
  { import = "plugins.git" },

  -- UI
  { import = "plugins.ui" },

  -- Editor enhancements
  { import = "plugins.editor" },

  -- Terminal
  { import = "plugins.terminal" },

  -- Keep vim-fugitive for git commands
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse" },
    keys = {
      { "<leader>ga", "<cmd>Git add .<CR>", desc = "Git add all" },
      { "<leader>gA", "<cmd>Git add %<CR>", desc = "Git add current" },
      { "<leader>gb", "<cmd>Git blame<CR>", desc = "Git blame" },
      { "<leader>gB", "<cmd>GBrowse<CR>", desc = "Git browse" },
      { "<leader>gc", "<cmd>Git commit<CR>", desc = "Git commit" },
      { "<leader>gd", "<cmd>Git diff<CR>", desc = "Git diff" },
      { "<leader>gD", "<cmd>Gdiffsplit<CR>", desc = "Git diff split" },
      { "<leader>gG", "<cmd>Git status<CR>", desc = "Git status" },
      { "<leader>gl", "<cmd>Git log<CR>", desc = "Git log" },
      { "<leader>gp", "<cmd>Git push<CR>", desc = "Git push" },
      { "<leader>gP", "<cmd>Git pull<CR>", desc = "Git pull" },
    },
  },

  -- CamelCaseMotion
  {
    "bkad/CamelCaseMotion",
    init = function()
      vim.g.camelcasemotion_key = "<leader>"
    end,
  },

  -- Indent text object
  { "michaeljsmith/vim-indent-object" },
}
