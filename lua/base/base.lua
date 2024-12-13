local g = vim.g
local o = vim.o
local opt = vim.opt

-- Map leader keys
g.mapleader = " "
g.maplocalleader = ","

-- Better editor UI
o.number = true
o.relativenumber = true
o.signcolumn = "auto"
o.foldcolumn = "auto"
o.cursorline = true
o.splitbelow = true
o.splitright = true
o.mouse = "a"
o.showmode = false
o.hlsearch = true

-- Colours
o.termguicolors = true
o.background = "dark"

-- Decrease update time
o.timeoutlen = 1000
o.updatetime = 200

-- Number of screen lines to keep above and below the cursor
o.scrolloff = 4

-- Better editing experience
o.expandtab = true
o.smarttab = true
o.autoindent = true
o.smartindent = true
o.wrap = true
o.linebreak = true
o.textwidth = 300
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = -1 -- If negative, shiftwidth value is used
o.list = false
o.listchars = "trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂"
o.undofile = true
-- o.listchars = 'eol:¬,space:·,lead: ,trail:·,nbsp:◇,tab:→-,extends:▸,precedes:◂,multispace:···⬝,leadmultispace:│   ,'

-- Makes neovim and host OS clipboard play nicely with each other
o.clipboard = "unnamedplus"

-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

-- Enable EXRC
o.exrc = true
