vim.opt_local.textwidth = 80
vim.opt_local.formatoptions = vim.opt_local.formatoptions + "t"

local function toggle_auto_wrap()
	local fo = vim.opt_local.formatoptions
	if fo:get()["t"] then
		print("Disabling auto-wrap")
		vim.opt_local.formatoptions = fo - "t"
	else
		print("Enabling auto-wrap")
		vim.opt_local.formatoptions = fo + "t"
	end
end

vim.api.nvim_create_user_command("ToggleAutoWrap", toggle_auto_wrap,{})
