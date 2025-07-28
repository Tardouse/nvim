return {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
        jump = {
            jumplist = true,
            pos = "start", ---@type "start" | "end" | "range"
            history = false,
            register = false,
            nohlsearch = false,
            autojump = false,
            inclusive = nil, ---@type boolean?
        },
        prompt = {
            enabled = true,
            prefix = { { "⚡", "FlashPromptIcon" } },
            win_config = {
                relative = "editor",
                width = 1, -- when <=1 it's a percentage of the editor width
                height = 1,
                row = -1,  -- when negative it's an offset from the bottom
                col = 0,   -- when negative it's an offset from the right
                zindex = 1000,
            },
        },
        label = {
            uppercase = false,
            exclude = "",
            current = false,
            -- show the label after the match
            after = true, ---@type boolean|number[]
            -- show the label before the match
            before = false, ---@type boolean|number[]
            -- position of the label extmark
            style = "inline", ---@type "eol" | "overlay" | "right_align" | "inline"
            -- flash tries to re-use labels that were already assigned to a position,
            -- when typing more characters. By default only lower-case labels are re-used.
            reuse = "all", ---@type "lowercase" | "all"
            -- for the current window, label targets closer to the cursor first
            distance = true,
            -- minimum pattern length to show labels
            -- Ignored for custom labelers.
            min_pattern_length = 0,
            -- Enable this to use rainbow colors to highlight labels
            -- Can be useful for visualizing Treesitter ranges.
            rainbow = {
                enabled = true,
                -- number between 1 and 9
                shade = 8,
            },
        },
        modes = {
            search = {
                enabled = false,
            },
            char = {
                enabled = false,
            },
            treesitter = {
                jump = { pos = "range" },
                search = { incremental = false },
                label = { before = true, after = true, style = "inline" },
                highlight = {
                    backdrop = false,
                    matches = false,
                },
            },
            treesitter_search = {
                jump = { pos = "range" },
                search = { multi_window = true, wrap = true, incremental = false },
                remote_op = { restore = true },
                label = { before = true, after = true, style = "inline" },
            },
            -- options used for remote flash
            remote = {
                remote_op = { restore = true, motion = true },
            },
        },
    },

    -- stylua: ignore
    keys = {
        { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
        { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
        { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
        { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
}
