return {
	"tpope/vim-surround",
	"jiangmiao/auto-pairs",
	"dkarter/bullets.vim",
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	"mbbill/undotree",
}
