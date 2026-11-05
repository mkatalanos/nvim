return { -- Autoformat
	"stevearc/conform.nvim",
	opts = {
		notify_on_error = true,
		formatters_by_ft = {
			fortran = { "fprettify" },
			json = { "prettier" },
			julia = { "runic" },
			lua = { "stylua" },
			python = { "autopep8" },
			rust = { "rustfmt" },
			yaml = { "prettier" },
		},
		default_format_opts = {
			lsp_format = "fallback"
		},
	},
}
