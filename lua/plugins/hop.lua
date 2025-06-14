return {
    "phaazon/hop.nvim",
    opts = { keys = "etovxqpdygfblzhckisuran" },
    keys = {
        { "<LocalLeader><LocalLeader>f", ":HopChar1<CR>",             desc = "Hop to char" },
        { "<LocalLeader><LocalLeader>F", ":HopChar1<CR>",             desc = "Hop to char" },
        { "<LocalLeader><LocalLeader>/", ":HopPattern<CR>",           desc = "Hop pattern" },
        { "<LocalLeader><LocalLeader>?", ":HopPatternBC<CR>",         desc = "Hop pattern before cursor" },
        { "<LocalLeader><LocalLeader>w", ":HopWord<CR>",              desc = "Hop word" },
        { "<LocalLeader><LocalLeader>b", ":HopWordCurrentLineBC<CR>", desc = "Hop back in current line" },
    },
}
