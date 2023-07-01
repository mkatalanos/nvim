-- Some remaps are stolen from the primeagen

-- Move visual selection using J K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Paste without deleting buffer
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Copy to clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])

-- Delete to void
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Disable Evil mode
vim.keymap.set("n", "Q", ":qa!<CR>", {remap = true})

-- Substitute current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- VS code style toggle wrap
vim.keymap.set("", "<M-z>", function()vim.cmd[[set wrap!]]end)


