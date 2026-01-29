-- Python-specific settings

local opt = vim.opt_local

opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true
opt.textwidth = 88 -- Black formatter default

-- Run current file
vim.keymap.set("n", "<leader>rr", "<cmd>!python3 %<CR>", { buffer = true, desc = "Run Python file" })
