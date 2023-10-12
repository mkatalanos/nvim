local M = {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' }, -- Required
        {                            -- Optional
            'williamboman/mason.nvim',
            build = function()
                pcall(vim.cmd, 'MasonUpdate')
            end,
        },
        { 'williamboman/mason-lspconfig.nvim' }, -- Optional

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },     -- Required
        { 'hrsh7th/cmp-nvim-lsp' }, -- Required
        { 'L3MON4D3/LuaSnip' },     -- Required

        -- Formatting
        { "jose-elias-alvarez/null-ls.nvim" }, -- Required
    },
    config = function()
        local lsp = require('lsp-zero').preset({})

        lsp.on_attach(function(client, bufnr)
            lsp.default_keymaps({ buffer = bufnr })
        end)

        -- (Optional) Configure lua language server for neovim
        require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
        require('lspconfig').ltex.setup({
            settings = {
                ltex = {
                    language = "en-GB",
                    setenceCacheSize = 2000,
                    additionalRules = {
                        enablePickyRules = true,
                        motherTongue = "el-GR"
                    },
                    -- languageToolHttpServerUri="http://localhost:8010"
                }
            },
        })
        -- Make sure you setup `cmp` after lsp-zero

        local cmp = require('cmp')
        local cmp_action = require('lsp-zero').cmp_action()

        cmp.setup({
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            -- completion = {
            --     autocomplete = false
            -- },
            mapping = {
                ['<Tab>'] = cmp_action.tab_complete(),
                ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
                ['<C-Space>'] = cmp.mapping.complete(),
            }
        })
        lsp.setup()

        local null_ls = require "null-ls"
        local formatting = null_ls.builtins.formatting

        null_ls.setup {
            sources = {
                formatting.prettier,
                formatting.verible_verilog_format,
                formatting.autopep8,
            }
        }
    end
}

vim.keymap.set({ "n"}, "<M-CR>",[[:lua vim.lsp.buf.code_action()<CR>]])

return M
