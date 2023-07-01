local M= {
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config=function()
        local actions = require("telescope.actions")
        require('telescope').setup{
            defaults ={
                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                    },
                },
            },
        }
    end
}

vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', {})
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>', {})
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', {})
vim.keymap.set('n', '<leader>fh', ':Telescope help_tags<CR>', {})
vim.keymap.set('n', '<C-p>', ':Telescope git_files<CR>', {})

return M
