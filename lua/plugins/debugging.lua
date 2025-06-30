return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"igorlfs/nvim-dap-view",
			opts = {
				winbar = {
					controls = {
						enabled = true,
					},
				},
			},
		},
		"leoluz/nvim-dap-go",
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		local dap, dv = require("dap"), require("dap-view")
		dap.listeners.before.attach["dap-view-config"] = function()
			dv.open()
		end
		dap.listeners.before.launch["dap-view-config"] = function()
			dv.open()
		end
		dap.listeners.before.event_terminated["dap-view-config"] = function()
			dv.close()
		end
		dap.listeners.before.event_exited["dap-view-config"] = function()
			dv.close()
		end

		-- Language specific stuff
		require("dap-go").setup()
		require("dap-python").setup()

		-- Keybinds
		local map = function(modes, keys, func, desc)
			vim.keymap.set(modes, keys, func, { desc = "DAP: " .. desc })
		end

		map("n", "<F4>", dap.continue, "Continue / Start Debugging")
		map("n", "<F6>", dap.step_over, "Step Over")
		map("n", "<F7>", dap.step_into, "Step Into")
		map("n", "<F8>", dap.step_out, "Step Out")
		map("n", "<LocalLeader>b", dap.toggle_breakpoint, "Toggle Breakpoint")
		map("n", "<LocalLeader>B", dap.clear_breakpoints, "Clear breakpoints")
		map("n", "<LocalLeader>lp", function()
			dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
		end, "Log point message")
		map("n", "<LocalLeader>dl", dap.run_last, "Run last")
		map({ "n", "v" }, "<LocalLeader>dh", function()
			require("dap.ui.widgets").hover()
		end, "Hover evaluate")
		map("n", "<LocalLeader>df", function()
			local widgets = require("dap.ui.widgets")
			widgets.sidebar(widgets.frames).toggle()
		end, "Show Frames")
		map("n", "<LocalLeader>ds", function()
			local widgets = require("dap.ui.widgets")
			widgets.sidebar(widgets.scopes).toggle()
		end, "Show scopes")
		map("n", "<Leader>dt", function()
			dv.toggle()
		end, "Toggle Debug View")
	end,
}
