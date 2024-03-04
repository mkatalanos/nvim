local M = { "tpope/vim-commentary" }

vim.keymap.set('n', '<C-_>', 'gcc', { remap = true })
vim.keymap.set('v', '<C-_>', 'gc', { remap = true })

return M
