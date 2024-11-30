-- Gotham
local Gotham = {
	"whatyouhide/vim-gotham",
	name = "Gotham",
	priority = 1000,
	lazy = false,
	config = function()
		vim.cmd.colorscheme("gotham256")
	end,
}

-- Nordtheme
local Nord = {
	"nordtheme/vim",
	name = "Nord",
	priority = 1000,
	lazy = false,
	config = function()
		vim.cmd.colorscheme("nord")
	end,
}

-- Kanagawa
local Kanagawa = {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		local dark = true
		local switch_theme = function()
			if dark then
				vim.cmd.colorscheme("kanagawa-lotus")
				dark = false
			else
				vim.cmd.colorscheme("kanagawa")
				dark = true
			end
		end
		vim.api.nvim_create_user_command("SwitchTheme", switch_theme, {})
		vim.cmd.colorscheme("kanagawa")

	end,
}

-- Catppuccin
local Catppuccin = {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	lazy = false,
	config = function()
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}

-- Gruvbox
local Gruvbox = {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		require("gruvbox")
		vim.o.background = "dark"
		vim.cmd.colorscheme("gruvbox")
	end,
}

-- Solarized Dark
local Solarized = {
	"ishan9299/nvim-solarized-lua",
	priority = 1000,
	lazy = false,
	config = function()
		vim.cmd.colorscheme("solarized")
	end,
}

return Kanagawa
