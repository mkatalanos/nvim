return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		bufdelete = { enabled = true },
		image = {
			enabled = true,
			doc = {
				enabled = false,
				inline = false,
				hover = false,
			},
			convert = {
				notify = false,
			},
		},
		zen = { enabled = true },
	},
	config = function(_, opts)
		require("snacks").setup(opts)

		local Snacks = require("snacks")

		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { desc = "Snacks: " .. desc })
		end

		map("<Leader>bd", function()
			Snacks.bufdelete()
		end, "Bufdelete")
		map("<Leader>bo", Snacks.bufdelete.other, "Bufdelete other")
		map("<Leader>ba", Snacks.bufdelete.all, "Bufdelete all")
		map("<Leader>bz", function()
			Snacks.zen()
		end, "Toggle Zen Mode")
		map("<LocalLeader>k", function()
			Snacks.image.hover()
		end, "Hover Image")
	end,
}
