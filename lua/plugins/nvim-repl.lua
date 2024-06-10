local M = {
    "pappasam/nvim-repl",
    init = function()
        vim.g["repl_filetype_commands"] = {
            javascript = "node",
            python = "ipython --no-autoindent",
            haskell = "cabal repl",
            rust = "cargo run",
            go = "go run .",
            glsl = "go run .",

        }

        vim.g["repl_split"] = 'bottom'
    end,
    keys = {
        { "<leader>rt", "<cmd>ReplToggle<cr>",  desc = "Toggle nvim-repl" },
        { "<leader>rc", "<cmd>ReplRunCell<cr>", desc = "nvim-repl run cell" },
        { "<leader>rr", "<cmd>Repl zsh<cr>",    desc = "Launch nvim-repl" },
    },
}


return M
