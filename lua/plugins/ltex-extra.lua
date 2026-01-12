return {
	"barreiroleo/ltex-extra.nvim",
	branch = "dev",
	-- commit = "5b37806dfbadeb8d6c0f1ee03140a60ffa40852c",
	ft = { "markdown", "tex", "latex" },
	build = function()
		local path = vim.fn.stdpath("data") .. "/ltex_extra/"
		vim.fn.mkdir(path, "p")
	end,
	opts = {
		load_langs = { "en-GB", "el-GR" },
		path = vim.fn.stdpath("data") .. "/ltex_extra/",
	},
}
