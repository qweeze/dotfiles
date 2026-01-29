-- JavaScript-specific settings

local opt = vim.opt_local

opt.shiftwidth = 2
opt.tabstop = 2
opt.expandtab = true

-- Run current file
vim.keymap.set("n", "<leader>rr", "<cmd>!node %<CR>", { buffer = true, desc = "Run JavaScript file" })
