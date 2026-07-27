return {
	"jpalardy/vim-slime",
	ft = { "python", "julia", "bash", "zsh" },
	init = function()
		vim.g.slime_target = "neovim"
		vim.g.slime_no_mappings = true
	end,
	config = function()
		vim.g.slime_suggest_default = true
		vim.g.slime_menu_config = true

		local keymap = function(mode, keys, func, desc)
			vim.keymap.set(mode, keys, func, { silent = false, desc = "Slime: " .. desc })
		end

		keymap("n", "<LocalLeader>f", "<Plug>SlimeMotionSend", "Send Motion")
		keymap("n", "<LocalLeader>ff", "<Plug>SlimeParagraphSend", "Send Block")
		keymap("x", "<LocalLeader>f", "<Plug>SlimeRegionSend", "Send Selected Region")
		keymap("n", "<LocalLeader>fc", "<Plug>SlimeConfig", "Config")
	end,
}
