-- Autocommands

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Auto-reload config on save
augroup("ReloadConfig", { clear = true })
autocmd("BufWritePost", {
  group = "ReloadConfig",
  pattern = vim.fn.expand("~") .. "/.config/nvim/**/*.lua",
  callback = function(args)
    dofile(args.file)
    vim.notify("Config reloaded: " .. args.file, vim.log.levels.INFO)
  end,
})

-- Python root patterns for LSP
augroup("PythonRootPatterns", { clear = true })
autocmd("FileType", {
  group = "PythonRootPatterns",
  pattern = "python",
  callback = function()
    vim.b.root_patterns = { ".git", ".env", "venv", "setup.cfg", "pyproject.toml", ".venv" }
  end,
})

-- Remove trailing whitespace on save
augroup("TrimWhitespace", { clear = true })
autocmd("BufWritePre", {
  group = "TrimWhitespace",
  pattern = "*",
  callback = function()
    if not vim.bo.modifiable or vim.bo.readonly then
      return
    end
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Restore cursor position
augroup("RestoreCursor", { clear = true })
autocmd("BufReadPost", {
  group = "RestoreCursor",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Close certain windows with q
augroup("CloseWithQ", { clear = true })
autocmd("FileType", {
  group = "CloseWithQ",
  pattern = { "help", "lspinfo", "man", "notify", "qf", "checkhealth" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
})

-- Auto-resize splits when window is resized
augroup("ResizeSplits", { clear = true })
autocmd("VimResized", {
  group = "ResizeSplits",
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})
