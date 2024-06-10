return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
			},
			sections = {
				lualine_c = {
					{ "filename", path = 1 },
				},
				lualine_y = {
					{
						function()
							local word_count = vim.fn.wordcount()
							if word_count.visual_words then
								return "Visual Words: " .. word_count.visual_words
							end
							return "Words: " .. word_count["words"]
						end,
						cond = function()
							local ft = vim.opt_local.filetype:get()
							local count = {
								latex = true,
								tex = true,
								text = true,
								markdown = true,
								vimwiki = true,
							}
							return count[ft] ~= nil
						end,
					},
				},
			},
		})
	end,
}
