local M = {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- 'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function()
        local actions = require("telescope.actions")
        require('telescope').setup {
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                    },
                },
            },
        }
        -- require('telescope').load_extension("ui-select")
    end
}


vim.keymap.set('n', '<space>ff', ':Telescope find_files<CR>', { silent = true, remap = true })
vim.keymap.set('n', '<space>fg', ':Telescope live_grep<CR>', { silent = true, remap = true })
vim.keymap.set('n', '<space>fb', ':Telescope buffers<CR>', { silent = true, remap = true })
vim.keymap.set('n', '<space>b', ':Telescope buffers<CR>', { silent = true, remap = true })
vim.keymap.set('n', '<space>fh', ':Telescope help_tags<CR>', { silent = true, remap = true })
vim.keymap.set('n', '<space>fm', ':Telescope keymaps<CR>', { silent = true, remap = true })
vim.keymap.set('n', '<space>m', ':Telescope keymaps<CR>', { silent = true, remap = true })

vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', {})
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>', {})
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', {})
vim.keymap.set('n', '<leader>fh', ':Telescope help_tags<CR>', {})
vim.keymap.set('n', '<leader>fm', ':Telescope keymaps<CR>', {})

vim.keymap.set('n', '<C-p>', function()
    local is_dir = function(path)
        local ok = vim.loop.fs_stat(path)
        return ok
    end
    local path = vim.loop.cwd() .. '/.git'
    if is_dir(path) then
        vim.cmd('Telescope git_files')
    else
        vim.cmd('Telescope find_files')
    end
end, {})

return M
