local M = { "phaazon/hop.nvim", opts = { keys = 'etovxqpdygfblzhckisuran' } }

vim.keymap.set('', '<LocalLeader><LocalLeader>f', ':HopChar1<CR>', { remap = true })
vim.keymap.set('', '<LocalLeader><LocalLeader>F', ':HopChar1<CR>', { remap = true })
vim.keymap.set('', '<LocalLeader><LocalLeader>/', ':HopPattern<CR>', { remap = true })
vim.keymap.set('', '<LocalLeader><LocalLeader>?', ':HopPatternBC<CR>', { remap = true })
-- vim.keymap.set('', '<LocalLeader><LocalLeader>w', ':HopWordCurrentLine<CR>', { remap = true })
vim.keymap.set('', '<LocalLeader><LocalLeader>w', ':HopWord<CR>', { remap = true })
vim.keymap.set('', '<LocalLeader><LocalLeader>b', ':HopWordCurrentLineBC<CR>', { remap = true })

return M
