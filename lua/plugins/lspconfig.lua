return {
	"neovim/nvim-lspconfig",

	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for neovim
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Autocomplete
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/nvim-cmp",

		-- Ltex-extra
		{
			"barreiroleo/ltex-extra.nvim",
			build = function()
				local path = vim.fn.stdpath("data") .. "/ltex_extra/"
				vim.fn.mkdir(path, "p")
			end,
		},
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				local builtin = require("telescope.builtin")
				local conform = require("conform")

				map("K", vim.lsp.buf.hover, "Hover Documentation")
				map("gd", builtin.lsp_definitions, "[G]oto [d]efinition")
				map("gD", vim.lsp.buf.declaration, " [G]oto [D]eclaration")
				map("gi", builtin.lsp_implementations, "[G]oto [i]mplementations")
				map("go", builtin.lsp_type_definitions, "[G]oto type definiti[o]ns")
				map("gr", builtin.lsp_references, "[G]oto [R]eferences")
				map("<Leader>sd", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<Leader>sw", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
				map("<F2>", vim.lsp.buf.rename, "Rename variable")
				map("<F3>", vim.lsp.buf.format, "Autoformat using LSP")
				map("<LocalLeader><F3>", conform.format, "Autoformat using Conform")
				map("<F4>", vim.lsp.buf.code_action, "Code action")
				map("<M-CR>", vim.lsp.buf.code_action, "Code action")

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.server_capabilities.documentHighlightProvider then
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.clear_references,
					})
				end
			end,
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		local servers = {
			clangd = {},
			lua_ls = {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							library = {
								"${3rd}/luv/library",
								unpack(vim.api.nvim_get_runtime_file("", true)),
							},
						},
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},
			pylsp = {
				settings = {
					pylsp = {
						plugins = {
							pycodestyle = {
								enabled = false,
							},
						},
					},
				},
			},
			-- basedpyright = {
			-- 	settings = {
			-- 		basedpyright = {
			-- 			analysis = {
			-- 				typeCheckingMode = "off",
			-- 			},
			-- 		},
			-- 	},
			-- },
			ltex = {
				settings = {
					ltex = {
						language = "en-GB",
						setenceCacheSize = 2000,
						additionalRules = {
							enablePickyRules = true,
							motherTongue = "el-GR",
						},
					},
				},
				on_attach = function(_client, _bufnr)
					require("ltex_extra").setup({
						load_langs = { "en-GB", "el-GR" },
						path = vim.fn.stdpath("data") .. "/ltex_extra/",
					})
				end,
			},
			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
						check = {
							command = "clippy",
						},
					},
				},
			},
			glsl_analyzer = {},
			gopls = {},
			yamlls = {},
			hls = {},
			-- fortls = {},
			-- tailwindcss = {
			-- 	filetypes = { "django-html", "htmldjango", "gohtml", "gohtmltmpl", "haml", "handlebars", "html",
			-- 		"html-eex", "heex", "php", "css", "postcss", "scss", "javascript", "javascriptreact", "typescript",
			-- 		"typescriptreact", "vue", "svelte", "templ",
			-- 	},
			-- },
		}

		local ensure_installed = vim.tbl_keys(servers or {})

		-- Mason ensure installed Formatters etc
		vim.list_extend(ensure_installed, {
			-- DAPs
			"delve",
			-- Formatters
			"stylua",
			"autopep8",
			"isort",
			"prettier",
			-- "fprettify"
		})

		require("mason").setup()
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local exceptions = {}
					for _, var in ipairs(exceptions) do
						if server_name == var then
							return true
						end
					end
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})

		-- Enable borders

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
		vim.diagnostic.config({ float = { border = "rounded" } })
	end,
}
