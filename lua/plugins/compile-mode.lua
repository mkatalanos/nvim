return {
	"ej-shafran/compile-mode.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		vim.g.compile_mode = {
			bang_expansion = true,
			default_command = "",
		}

		local compile = require("compile-mode")

		local compile_ran = false

		local function compile_then_recompile()
			if compile_ran then
				compile.recompile()
			else
				compile.compile()
				compile_ran = true
			end
		end
		vim.keymap.set("n", "<F5>", compile_then_recompile, { desc = "Compile Mode: Set command and rerun" })
	end,
}
