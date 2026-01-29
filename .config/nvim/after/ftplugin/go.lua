-- Go-specific settings

local opt = vim.opt_local

opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = false -- Go uses tabs

-- Run current file
vim.keymap.set("n", "<leader>rr", "<cmd>!go run %<CR>", { buffer = true, desc = "Run Go file" })
