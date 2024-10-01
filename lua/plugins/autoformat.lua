return { -- Autoformat
	"stevearc/conform.nvim",
	opts = {
		notify_on_error = true,
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "autopep8" },
			markdown = { "prettier" },
			rust = { "rustfmt" },
			typescript = { "prettier" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			yaml = { "prettier" },
			fortran = {"fprettify"}
		},
		lsp_fallback = true,
	},
}
