-- Rust-specific settings

local opt = vim.opt_local

opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true

-- Run with cargo
vim.keymap.set("n", "<leader>rr", "<cmd>!cargo run<CR>", { buffer = true, desc = "Cargo run" })
vim.keymap.set("n", "<leader>rt", "<cmd>!cargo test<CR>", { buffer = true, desc = "Cargo test" })
vim.keymap.set("n", "<leader>rb", "<cmd>!cargo build<CR>", { buffer = true, desc = "Cargo build" })
