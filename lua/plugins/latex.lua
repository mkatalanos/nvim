return {
	"lervag/vimtex",
	lazy = false, -- we don't want to lazy load VimTeX
	init = function()
		vim.g.vimtex_complete_enabled = 0
		vim.g.vimtex_quickfix_enabled = 0
	end,
}
