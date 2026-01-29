-- TypeScript-specific settings

local opt = vim.opt_local

opt.shiftwidth = 2
opt.tabstop = 2
opt.expandtab = true

-- Run current file (requires ts-node or similar)
vim.keymap.set("n", "<leader>rr", "<cmd>!npx ts-node %<CR>", { buffer = true, desc = "Run TypeScript file" })
