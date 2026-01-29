-- Key mappings

local map = vim.keymap.set

-- Exit insert mode with jk
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Clear search highlighting with Enter
map("n", "<CR>", ":noh<CR>:<Backspace><CR>", { silent = true, desc = "Clear search highlight" })

-- Use Ctrl-p as Ctrl-i (jump forward)
map("n", "<C-p>", "<C-i>", { desc = "Jump forward" })

-- Window navigation
map("n", "<Leader>h", "<cmd>wincmd h<CR>", { desc = "Move to left window" })
map("n", "<Leader>j", "<cmd>wincmd j<CR>", { desc = "Move to below window" })
map("n", "<Leader>k", "<cmd>wincmd k<CR>", { desc = "Move to above window" })
map("n", "<Leader>l", "<cmd>wincmd l<CR>", { desc = "Move to right window" })

-- Save file
map("n", "<Leader>w", "<cmd>w<CR>", { desc = "Save file" })

-- Delete buffer
map("n", "<Leader>x", "<cmd>bd<CR>", { desc = "Delete buffer" })

-- Terminal escape
map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Diagnostic navigation (similar to coc [g ]g)
map("n", "[g", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]g", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- Keep visual selection when indenting
map("v", "<", "<gv", { desc = "Indent left and keep selection" })
map("v", ">", ">gv", { desc = "Indent right and keep selection" })

-- Move lines up/down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Better scrolling (keep cursor centered)
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })

-- Search results centered
map("n", "n", "nzzzv", { desc = "Next search result" })
map("n", "N", "Nzzzv", { desc = "Previous search result" })
