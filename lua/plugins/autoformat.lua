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
			fortran = { "fprettify" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			json = { "prettier" },
			julia = { "runic" },
			lua = { "stylua" },
			markdown = { "mdformat" },
			python = { "autopep8" },
			rust = { "rustfmt" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			yaml = { "prettier" },
		},
		default_format_opts = {
			lsp_format = "fallback"
		},
	},
}
