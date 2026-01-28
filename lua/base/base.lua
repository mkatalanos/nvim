local g = vim.g
local o = vim.o

-- Map leader keys
g.mapleader = " "
g.maplocalleader = ","

-- Better editor UI
o.number = true
o.relativenumber = true
o.signcolumn = "auto"
o.cursorline = true
o.splitbelow = true
o.splitright = true
o.mouse = "a"
o.showmode = false
o.hlsearch = true
o.winborder = "rounded"

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
o.foldlevel = 99
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = -1 -- If negative, shiftwidth value is used
-- o.list = true
o.undofile = true
vim.opt.listchars = {
	tab = "│ ",
	trail = "·",
	precedes = "◂",
	extends = "▸",
	nbsp = "◇",
	space = " ",
	-- multispace = "·",
}

-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

-- Enable EXRC
o.exrc = true

-- Set default tex flavour
vim.g.tex_flavor = "latex"

-- Clipboard
if vim.env.WAYLAND_DISPLAY then
	vim.opt.clipboard = "unnamedplus"
end
