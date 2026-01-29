-- Vim options

local opt = vim.opt

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Indentation
opt.smartindent = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true

-- Display
opt.wrap = false
opt.number = true
opt.relativenumber = true
opt.ruler = true
opt.laststatus = 2
opt.cmdheight = 2
opt.signcolumn = "yes"
opt.termguicolors = true
opt.background = "dark"

-- Behavior
opt.clipboard = "unnamedplus"
opt.hidden = true
opt.updatetime = 300
opt.timeoutlen = 500
opt.wildmode = { "longest", "full" }
opt.wildmenu = true
opt.ttyfast = true
opt.errorbells = false
opt.shortmess:append("atIc")

-- Backup/Swap/Undo directories
local data_dir = vim.fn.stdpath("data")
opt.backupdir = data_dir .. "/backup//"
opt.directory = data_dir .. "/swap//"
opt.undodir = data_dir .. "/undo//"
opt.undofile = true

-- Create directories if they don't exist
vim.fn.mkdir(data_dir .. "/backup", "p")
vim.fn.mkdir(data_dir .. "/swap", "p")
vim.fn.mkdir(data_dir .. "/undo", "p")

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }

-- Split behavior
opt.splitbelow = true
opt.splitright = true

-- Mouse
opt.mouse = "a"

-- Scrolloff
opt.scrolloff = 8
opt.sidescrolloff = 8
