return {
	"numToStr/Comment.nvim",
	config = function()
		require("Comment").setup()
		vim.keymap.set("n", "<C-_>", "gcc", { remap = true })
		vim.keymap.set("n", "<C-/>", "gcc", { remap = true })
		vim.keymap.set("v", "<C-_>", "gc", { remap = true })
		vim.keymap.set("v", "<C-/>", "gc", { remap = true })
	end,
	lazy = false,
}
