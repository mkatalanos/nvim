return { -- Autoformat
	"stevearc/conform.nvim",
	opts = {
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
		},
		lsp_fallback = true,
	},
}
