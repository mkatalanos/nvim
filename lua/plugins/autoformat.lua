return { -- Autoformat
	"stevearc/conform.nvim",
	opts = {
		-- formatters = {
		-- 	miss_hit = {
		-- 		command = "mh_style",
		-- 		args = { "--fix", "$FILENAME" },
		-- 		stdin = false,
		-- 		tmpfile_format = ".conform.$RANDOM.$FILENAME",
		-- 		exit_codes = { 0, 1 },
		-- 	},
		-- },
		notify_on_error = true,
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "autopep8" },
			markdown = { "prettier" },
			rust = { "rustfmt" },
			typescript = { "prettier" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			fortran = { "fprettify" },
			tex = { "latexindent" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			-- matlab = { "miss_hit" },
		},
		lsp_fallback = true,
	},
}
