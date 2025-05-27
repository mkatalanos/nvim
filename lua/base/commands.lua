local tcd = function()
	vim.cmd("tcd " .. vim.fn.expand("%:p:h"))
end

local lcd = function()
	vim.cmd("lcd " .. vim.fn.expand("%:p:h"))
end

local cd = function()
	vim.cmd("cd " .. vim.fn.expand("%:p:h"))
end

vim.api.nvim_create_user_command("Tcd", tcd, { desc = "tcd into open file's location" })
vim.api.nvim_create_user_command("Lcd", lcd, { desc = "lcd into open file's location" })
vim.api.nvim_create_user_command("Cd", cd, { desc = "cd into open file's location" })
