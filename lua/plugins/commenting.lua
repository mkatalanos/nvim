return {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
        vim.keymap.set('n', '<C-_>', 'gcc', { remap = true })
        vim.keymap.set('v', '<C-_>', 'gc', { remap = true })
    end,
    lazy = false,
}
