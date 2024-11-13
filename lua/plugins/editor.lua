local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' 󰁂 %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, 'MoreMsg' })
    return newVirtText
end


return {
    {
        -- Highlight the word under the cursor throughout the buffer
        "RRethy/vim-illuminate",
        config = function()
            require('illuminate').configure({
                providers = {
                    -- 'lsp',
                    -- 'treesitter',
                    'regex',
                },
            })
			-- vim.cmd("hi IlluminatedWordText guibg=#d70000 gui=none")
            vim.cmd [[
                hi IlluminatedWordText guifg=white guibg=#d7005f gui=none
                hi IlluminatedWordRead guifg=white guibg=#d7005f gui=none
                hi IlluminatedWordWrite guifg=white guibg=#d7005f gui=none
            ]]
        end
    },
    {
        -- auto add list bullets for markdown and text files
        "dkarter/bullets.vim",
        lazy = false,
        ft = { "markdown", "txt" },
    },
    {
        -- display the color of the hex code in the buffer
        "NvChad/nvim-colorizer.lua",
        opts = {
            filetypes = { "*" },
            user_default_options = {
                RGB = true,           -- #RGB hex codes
                RRGGBB = true,        -- #RRGGBB hex codes
                names = true,         -- "Name" codes like Blue or blue
                RRGGBBAA = false,     -- #RRGGBBAA hex codes
                AARRGGBB = true,      -- 0xAARRGGBB hex codes
                rgb_fn = false,       -- CSS rgb() and rgba() functions
                hsl_fn = false,       -- CSS hsl() and hsla() functions
                css = false,          -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = false,       -- Enable all CSS *functions*: rgb_fn, hsl_fn
                -- Available modes for `mode`: foreground, background,  virtualtext
                mode = "virtualtext", -- Set the display mode.
                -- Available methods are false / true / "normal" / "lsp" / "both"
                -- True is same as normal
                tailwind = true,
                sass = { enable = false },
                virtualtext = "■",
            },
            -- all the sub-options of filetypes apply to buftypes
            buftypes = {},
        }
    },
    { 'gcmt/wildfire.vim',  lazy = false, },
    -- {
    -- 	"fedepujol/move.nvim",
    -- 	config = function()
    -- 		require('move').setup({
    -- 			line = {
    -- 				enable = true,
    -- 				indent = true
    -- 			},
    -- 			block = {
    -- 				enable = true,
    -- 				indent = true
    -- 			},
    -- 			word = {
    -- 				enable = false,
    -- 			},
    -- 			char = {
    -- 				enable = false
    -- 			}
    -- 		})
    -- 		local opts = { noremap = true, silent = true }
    -- 		-- Normal-mode commands
    -- 		vim.keymap.set('n', '<c-y>', ':MoveLine(1)<CR>', opts)
    -- 		vim.keymap.set('n', '<c-l>', ':MoveLine(-1)<CR>', opts)

    -- 		-- Visual-mode commands
    -- 		vim.keymap.set('v', '<c-e>', ':MoveBlock(1)<CR>', opts)
    -- 		vim.keymap.set('v', '<c-u>', ':MoveBlock(-1)<CR>', opts)
    -- 	end
    -- },
    -- {
    -- 	"gbprod/substitute.nvim",
    -- 	config = function()
    -- 		local substitute = require("substitute")
    -- 		substitute.setup({
    -- 			-- on_substitute = require("yanky.integration").substitute(),
    -- 			highlight_substituted_text = {
    -- 				enabled = true,
    -- 				timer = 200,
    -- 			},
    -- 		})
    -- 		vim.keymap.set("n", "s", substitute.operator, { noremap = true })
    -- 		vim.keymap.set("n", "sh", function() substitute.operator({ motion = "e" }) end, { noremap = true })
    -- 		vim.keymap.set("x", "s", require('substitute.range').visual, { noremap = true })
    -- 		vim.keymap.set("n", "ss", substitute.line, { noremap = true })
    -- 		vim.keymap.set("n", "sI", substitute.eol, { noremap = true })
    -- 		vim.keymap.set("x", "s", substitute.visual, { noremap = true })
    -- 	end
    -- },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async", },
        config = function()
            require('ufo').setup({
                fold_virt_text_handler = handler
            })
        end
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end
    },
}
