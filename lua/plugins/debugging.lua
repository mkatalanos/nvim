return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"theHamsta/nvim-dap-virtual-text",
		"leoluz/nvim-dap-go",
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		local dap = require("dap")

		require("nvim-dap-virtual-text").setup({
			commented = true,
			only_first_definition = false,
			clear_on_continue = true,
		})

		-- Language specific stuff
		require("dap-go").setup()
		require("dap-python").setup()

		-- Keybinds
		local map = function(modes, keys, func, desc)
			vim.keymap.set(modes, keys, func, { desc = "DAP: " .. desc })
		end

		map("n", "<F5>", dap.continue, "Continue / Start Debugging")
		map("n", "<F6>", dap.step_over, "Step Over")
		map("n", "<F7>", dap.step_into, "Step Into")
		map("n", "<F8>", dap.step_out, "Step Out")
		map("n", "<Leader>b", dap.toggle_breakpoint, "Toggle Breakpoint")
		map("n", "<Leader>B", dap.clear_breakpoints, "Clear breakpoints")
		map("n", "<Leader>lp", function()
			dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
		end, "Log point message")
		map("n", "<Leader>dr", dap.repl.toggle, "REPL Open")
		map("n", "<Leader>dl", dap.run_last, "Run last")
		map({ "n", "v" }, "<Leader>dh", function()
			require("dap.ui.widgets").hover()
		end, "Hover evaluate")
		map("n", "<Leader>df", function()
			local widgets = require("dap.ui.widgets")
			widgets.sidebar(widgets.frames).toggle()
		end, "Show Frames")
		map("n", "<Leader>ds", function()
			local widgets = require("dap.ui.widgets")
			widgets.sidebar(widgets.scopes).toggle()
		end, "Show scopes")
	end,
}
