return {
	"stevearc/oil.nvim",
	config = function()
		require("oil").setup()
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		vim.keymap.set("n", "<leader>-", "<CMD>tabnew +Oil<CR>", { desc = "Open parent directory in a new tab" })
	end,
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
