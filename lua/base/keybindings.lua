-- Some remaps are stolen from the primeagen

-- Move visual selection using J K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Paste without deleting buffer
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Copy to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- Delete to void
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Disable Evil mode
vim.keymap.set("n", "Q", ":qa!<CR>", { remap = true })

-- Substitute current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- VS code style toggle wrap
vim.keymap.set("", "<M-z>", function() vim.cmd [[set wrap!]] end)


-- Run shell command on visual selection
vim.keymap.set("v", "<leader><CR>", [[:'<,'>!]])

-- Replace visual selection with pandoc latex
vim.keymap.set("v", "<leader>mark", [[:'<,'>! pandoc -f markdown -t latex --biblatex<CR>]])

-- Run Pandoc on Buffer
vim.keymap.set("n", "<leader>pd", function()
    local api = vim.api
    -- Get the current buffer's content
    local current_buffer = api.nvim_get_current_buf()
    local buffer_content = api.nvim_buf_get_lines(current_buffer, 0, -1, false)

    -- Join the lines into a single string
    local content_string = table.concat(buffer_content, "\n")

    -- Call the pandoc command on the content
    local command = "pandoc -f markdown -t latex --biblatex"
    local result = vim.fn.systemlist(command, content_string)


    -- Create an unnamed buffer
    local handle = api.nvim_create_buf(false, true)
    api.nvim_buf_set_lines(handle, 0, -1, false, result)

    -- Make a new split
    api.nvim_command('rightbelow vertical split')
    local window = api.nvim_get_current_win()
    api.nvim_win_set_buf(window, handle)
end)

-- Term escape instead of vimode
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

-- Enable spell checking
vim.keymap.set('n', '<leader>z=', [[:set spell! spelllang=en_gb<CR>]])
