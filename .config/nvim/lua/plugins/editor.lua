-- Editor Enhancements (which-key, flash, comment, zen-mode)

return {
  -- Which-key (lua version)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    config = function()
      local wk = require("which-key")

      wk.setup({
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
          presets = {
            operators = true,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
          },
        },
        icons = {
          breadcrumb = "»",
          separator = "→",
          group = "+",
        },
        win = {
          border = "rounded",
          padding = { 2, 2, 2, 2 },
        },
        layout = {
          height = { min = 4, max = 25 },
          width = { min = 20, max = 50 },
          spacing = 3,
          align = "left",
        },
        show_help = true,
      })

      -- Register key groups (matching original which-key config)
      wk.add({
        { "<leader>a", group = "actions" },
        { "<leader>c", group = "lsp" },
        { "<leader>g", group = "git" },
        { "<leader>q", group = "session" },
        { "<leader>r", group = "run" },
        { "<leader>s", group = "search" },
        { "<leader>t", group = "terminal" },
        { "<leader>w", group = "workspace" },
        { "<leader><leader>", group = "quick actions" },
      })
    end,
  },

  -- Flash (replacement for vim-sneak and quick-scope)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      labels = "asdfghjklqwertyuiopzxcvbnm",
      search = {
        mode = "fuzzy",
      },
      jump = {
        autojump = false,
      },
      label = {
        uppercase = false,
        rainbow = {
          enabled = false,
        },
      },
      highlight = {
        backdrop = true,
        matches = true,
      },
      modes = {
        search = {
          enabled = false, -- Don't hijack regular search
        },
        char = {
          enabled = true,
          -- Highlight unique characters (like quick-scope)
          highlight = { backdrop = false },
          jump_labels = true,
          keys = { "f", "F", "t", "T", ";", "," },
        },
      },
    },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
    },
  },

  -- Comment (replacement for vim-commentary)
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },

  -- TS context commentstring (for JSX, etc.)
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },

  -- Zen mode (replacement for goyo.vim)
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      { "<leader>z", "<cmd>ZenMode<CR>", desc = "Zen mode" },
    },
    opts = {
      window = {
        width = 120, -- Same as original goyo_width
        options = {
          signcolumn = "no",
          number = false,
          relativenumber = false,
          cursorline = false,
          cursorcolumn = false,
          foldcolumn = "0",
          list = false,
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
        },
        twilight = { enabled = true },
        gitsigns = { enabled = false },
        tmux = { enabled = true },
      },
    },
    dependencies = {
      {
        "folke/twilight.nvim",
        opts = {
          dimming = {
            alpha = 0.25,
          },
        },
      },
    },
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        typescript = { "string", "template_string" },
      },
      disable_filetype = { "TelescopePrompt" },
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0,
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
      -- Integrate with cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- Better escape (for jk mapping)
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {
      timeout = 300,
      default_mappings = false,
      mappings = {
        i = {
          j = {
            k = "<Esc>",
          },
        },
      },
    },
  },

  -- Run code (matching original run group)
  {
    "CRAG666/code_runner.nvim",
    cmd = { "RunCode", "RunFile", "RunProject" },
    keys = {
      { "<leader>rr", "<cmd>RunFile<CR>", desc = "Run file" },
      { "<leader>rp", "<cmd>RunProject<CR>", desc = "Run project" },
    },
    opts = {
      filetype = {
        python = "python3 -u",
        javascript = "node",
        typescript = "ts-node",
        rust = "cargo run",
        go = "go run",
      },
    },
  },

  -- Clear search highlight action
  {
    "folke/which-key.nvim",
    keys = {
      {
        "<leader>aa",
        function()
          vim.fn.setreg("/", "")
          print("Search highlight cleared")
        end,
        desc = "Clear search highlight",
      },
    },
  },
}
