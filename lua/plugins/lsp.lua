return {
	"neovim/nvim-lspconfig",

	dependencies = {

		-- Automatically install LSPs and related tools to stdpath for neovim
		{ "mason-org/mason.nvim", opts = {} },
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Autocomplete
		"hrsh7th/nvim-cmp",

		-- Status Updates
		-- { "j-hui/fidget.nvim", opts = {} },

		-- Ltex-extra
		{
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
		},
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end
				local imap = function(keys, func, desc)
					vim.keymap.set("i", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				local builtin = require("telescope.builtin")
				local lsp = vim.lsp.buf
				local conform = require("conform")

				map("K", function()
					vim.lsp.buf.hover({ border = "rounded" })
				end, "Hover Documentation")
				map("<C-S>", function()
					vim.lsp.buf.signature_help({ border = "rounded" })
				end, "Hover Documentation")

				imap("<C-S>", function()
					vim.lsp.buf.signature_help({ border = "rounded" })
				end, "Hover Documentation")
				map("gd", builtin.lsp_definitions, "[G]oto [d]efinition")
				map("gD", lsp.declaration, " [G]oto [D]eclaration")
				map("gi", builtin.lsp_implementations, "[G]oto [i]mplementations")
				map("go", builtin.lsp_type_definitions, "[G]oto type definiti[o]ns")
				map("grr", builtin.lsp_references, "[G]oto [R]eferences")
				map("<Leader>sd", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<Leader>sw", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
				map("<F2>", lsp.rename, "Rename variable")
				map("<F3>", lsp.format, "Autoformat using LSP")
				map("<LocalLeader><F3>", conform.format, "Autoformat using Conform")
				map("<M-CR>", lsp.code_action, "Code action")

				local client = vim.lsp.get_client_by_id(event.data.client_id)

				if
					client
					and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
				then
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						callback = lsp.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						callback = lsp.clear_references,
					})
				end

				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
					local toggle_inlay = function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end
					vim.api.nvim_buf_create_user_command(event.buf, "ToggleInlay", toggle_inlay, {})
				end
			end,
		})

		local servers = {
			clangd = {
				settings = {
					clangd = {
						arguments = { "--cuda-path=/usr/local/cuda/" },
					},
				},
			},
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
				-- settings = {
				-- 	pylsp = {
				-- 		plugins = {
				-- 			pycodestyle = {
				-- 				enabled = false,
				-- 			},
				-- 		},
				-- 	},
				-- },
			},
			ltex_plus = {
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
				-- on_attach = function(_client, _bufnr)
				-- 	require("ltex_extra").setup({
				-- 		load_langs = { "en-GB", "el-GR" },
				-- 		path = vim.fn.stdpath("data") .. "/ltex_extra/",
				-- 	})
				-- end,
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
			-- hls = {},
			texlab = {},
			mesonlsp = {}
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
		require("mason-lspconfig").setup({
			automatic_enable = vim.tbl_keys(servers or {}),
		})

		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		for server_name, config in pairs(servers) do
			vim.lsp.config(server_name, config)
		end

		-- Diagnostic Config
		vim.diagnostic.config({
			float = { border = "rounded" },
			virtual_text = { current_line = true },
		})
	end,
}
