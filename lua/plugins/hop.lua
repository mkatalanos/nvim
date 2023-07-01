local M = { "phaazon/hop.nvim", opts = { keys = 'etovxqpdygfblzhckisuran' } }

vim.keymap.set('', '<leader><leader>f', ':HopChar1CurrentLineAC<CR>', { remap = true })
vim.keymap.set('', '<leader><leader>F', ':HopChar1CurrentLineBC<CR>', { remap = true })
vim.keymap.set('', '<leader><leader>/', ':HopPattern<CR>', { remap = true })
vim.keymap.set('', '<leader><leader>?', ':HopPatternBC<CR>', { remap = true })
vim.keymap.set('', '<leader><leader>w', ':HopWordCurrentLine<CR>', { remap = true })
vim.keymap.set('', '<leader><leader>b', ':HopWordCurrentLineBC<CR>', { remap = true })

return M
