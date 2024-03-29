local g = vim.g
local o = vim.o
local opt = vim.opt
local cmd = vim.cmd

-- File Specific settings
cmd('syntax on')
vim.api.nvim_command('filetype plugin indent on')

-- Colours
o.termguicolors = true
o.background = 'dark'


-- Decrease update time
o.timeoutlen = 1000
o.updatetime = 200

-- Number of screen lines to keep above and below the cursor
o.scrolloff = 4

-- Better editor UI
o.number = true
o.relativenumber = true
o.signcolumn = "no"
o.cursorline = true
o.splitbelow = true
o.splitright = true

-- Better editing experience
o.expandtab = true
o.smarttab = true
o.cindent = false
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
-- o.listchars = 'eol:¬,space:·,lead: ,trail:·,nbsp:◇,tab:→-,extends:▸,precedes:◂,multispace:···⬝,leadmultispace:│   ,'
-- o.formatoptions = 'qrn1'

-- Makes neovim and host OS clipboard play nicely with each other
o.clipboard = "unnamedplus"


-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

opt.mouse = "a"

-- Map <leader> to ','
g.mapleader = ","
g.maplocalleader = ","
