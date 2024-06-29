return {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local actions = require("telescope.actions")
        require("telescope").setup({
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                    },
                },
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown(),
                },
            },
        })
        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<Leader>fh", builtin.help_tags, { desc = "[F]uzzy search [H]elp" })
        vim.keymap.set("n", "<Leader>fm", builtin.keymaps, { desc = "[F]uzzy search [K]eymaps" })
        vim.keymap.set("n", "<Leader>ff", builtin.find_files, { desc = "[F]uzzy search [F]iles" })
        vim.keymap.set("n", "<Leader>ft", builtin.builtin, { desc = "[F]uzzy search [T]elescope" })
        vim.keymap.set("n", "<Leader>fw", builtin.grep_string, { desc = "[F]uzzy search current [W]ord" })
        vim.keymap.set("n", "<Leader>fg", builtin.live_grep, { desc = "[F]uzzy search by [G]rep" })
        vim.keymap.set("n", "<Leader>fd", builtin.diagnostics, { desc = "[F]uzzy search [D]iagnostics" })
        vim.keymap.set("n", "<Leader>f.", builtin.oldfiles, { desc = '[F]uzzy search Recent Files ("." for repeat)' })
        vim.keymap.set("n", "<Leader><Leader>", builtin.buffers, { desc = "List buffers" })
        vim.keymap.set("n", "<Leader>m", builtin.marks, { desc = "Open [M]arks" })

        vim.keymap.set("n", "<Leader>/", function()
            builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                winblend = 10,
                previewer = false,
            }))
        end, { desc = "[/] Fuzzily search in current buffer" })

        vim.keymap.set("n", "<Leader>fn", function()
            builtin.find_files({ cwd = vim.fn.stdpath("config") })
        end, { desc = "[F]uzzy [N]eovim files" })
    end,
}
