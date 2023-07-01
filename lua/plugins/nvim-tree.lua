local M = {
    "nvim-tree/nvim-tree.lua",
    config = function()
        require("nvim-tree").setup({
            update_cwd = true,
            update_focused_file = {
                enable = true,
                update_cwd = true
            },
            view = {
                adaptive_size = true
            }
        })
    end
}

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set('n', '<c-n>', ':NvimTreeFindFileToggle<CR>', { silent = true })

return M
