-- Terminal Configuration (toggleterm)

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { "<C-t>", "<cmd>ToggleTerm<CR>", mode = { "n", "i" }, desc = "Toggle terminal" },
      { "<leader>tt", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
      { "<leader>t;", "<cmd>ToggleTerm direction=horizontal size=15<CR>", desc = "Terminal (bottom)" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Terminal (float)" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<CR>", desc = "Terminal (vertical)" },
      { "<leader>tn", function()
          local term = require("toggleterm.terminal").Terminal:new({ direction = "float" })
          term:toggle()
        end, desc = "New terminal" },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<C-t>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
        width = function()
          return math.floor(vim.o.columns * 0.6)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.8)
        end,
        row = function()
          return math.floor(vim.o.lines * 0.65)
        end,
        col = function()
          return math.floor(vim.o.columns * 0.58)
        end,
        title_pos = "right",
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
      on_open = function(term)
        local terms = require("toggleterm.terminal")
        local all_terms = terms.get_all()

        vim.api.nvim_win_set_config(term.window, {
          title = " term " .. term.id .. "/" .. #all_terms .. " ",
          title_pos = "right",
        })
      end,
      winbar = {
        enabled = false,
      },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      local terms = require("toggleterm.terminal")
      local next_term_id = 1

      -- Terminal keymaps
      function _G.set_terminal_keymaps()
        local term_opts = { buffer = 0 }
        vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], term_opts)
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], term_opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], term_opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], term_opts)

        -- C-t T: New terminal
        vim.keymap.set("t", "<C-t>T", function()
          next_term_id = next_term_id + 1
          vim.cmd(next_term_id .. "ToggleTerm")
          vim.schedule(function()
            vim.cmd("startinsert")
          end)
        end, term_opts)

        -- C-t n: Next terminal
        vim.keymap.set("t", "<C-t>n", function()
          local all_terms = terms.get_all()
          if #all_terms <= 1 then return end
          local current = terms.get_focused_id()
          for i, term in ipairs(all_terms) do
            if term.id == current then
              local next_term = all_terms[i % #all_terms + 1]
              next_term:open()
              vim.schedule(function() vim.cmd("startinsert") end)
              return
            end
          end
        end, term_opts)

        -- C-t p: Previous terminal
        vim.keymap.set("t", "<C-t>p", function()
          local all_terms = terms.get_all()
          if #all_terms <= 1 then return end
          local current = terms.get_focused_id()
          for i, term in ipairs(all_terms) do
            if term.id == current then
              local prev_term = all_terms[(i - 2) % #all_terms + 1]
              prev_term:open()
              vim.schedule(function() vim.cmd("startinsert") end)
              return
            end
          end
        end, term_opts)
      end

      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    end,
  },
}
