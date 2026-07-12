return {
	{
		"ap/vim-css-color",
		lazy = false,
		priority = 1000,
		config = function() end,
	},
	{
		"ryanoasis/vim-devicons",
		lazy = false,
		priority = 1000,
		config = function() end,
	},
	{
		"rafi/awesome-vim-colorschemes",
		lazy = false,
		priority = 1000,
		config = function() end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		-- config = function()
		--     -- vim.cmd.colorscheme "tokyonight-night"
		--     vim.cmd.colorscheme "tokyonight-moon"
		-- end,
	},
	-- {
	-- 	"catppuccin/nvim",
	-- 	lazy = false,
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("catppuccin").setup({
	-- 			flavour = "auto", -- latte, frappe, macchiato, mocha
	-- 			background = { -- :h background
	-- 				light = "latte",
	-- 				dark = "mocha",
	-- 			},
	-- 			transparent_background = false, -- disables setting the background color.
	-- 			float = {
	-- 				transparent = false, -- enable transparent floating windows
	-- 				solid = false, -- use solid styling for floating windows, see |winborder|
	-- 			},
	-- 			show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
	-- 			term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
	-- 			dim_inactive = {
	-- 				enabled = false, -- dims the background color of inactive window
	-- 				shade = "dark",
	-- 				percentage = 0.15, -- percentage of the shade to apply to the inactive window
	-- 			},
	-- 			no_italic = false, -- Force no italic
	-- 			no_bold = false, -- Force no bold
	-- 			no_underline = false, -- Force no underline
	-- 			styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
	-- 				comments = { "italic" }, -- Change the style of comments
	-- 				conditionals = { "italic" },
	-- 				loops = {},
	-- 				functions = {},
	-- 				keywords = {},
	-- 				strings = {},
	-- 				variables = {},
	-- 				numbers = {},
	-- 				booleans = {},
	-- 				properties = {},
	-- 				types = {},
	-- 				operators = {},
	-- 				-- miscs = {}, -- Uncomment to turn off hard-coded styles
	-- 			},
	-- 			lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
	-- 				virtual_text = {
	-- 					errors = { "italic" },
	-- 					hints = { "italic" },
	-- 					warnings = { "italic" },
	-- 					information = { "italic" },
	-- 					ok = { "italic" },
	-- 				},
	-- 				underlines = {
	-- 					errors = { "underline" },
	-- 					hints = { "underline" },
	-- 					warnings = { "underline" },
	-- 					information = { "underline" },
	-- 					ok = { "underline" },
	-- 				},
	-- 				inlay_hints = {
	-- 					background = true,
	-- 				},
	-- 			},
	-- 			color_overrides = {},
	-- 			custom_highlights = {},
	-- 			default_integrations = true,
	-- 			auto_integrations = false,
	-- 			integrations = {
	-- 				cmp = true,
	-- 				gitsigns = true,
	-- 				nvimtree = true,
	-- 				notify = false,
	-- 				mini = {
	-- 					enabled = false,
	-- 					indentscope_color = "",
	-- 				},
	-- 				-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	-- 			},
	-- 		})
	-- 		vim.cmd.colorscheme("catppuccin-mocha") --catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
	-- 	end,
	-- },
	{
		"ray-x/aurora",
		init = function()
            vim.opt.termguicolors = true
			vim.g.aurora_italic = 1
			vim.g.aurora_transparent = 1
			vim.g.aurora_bold = 0

			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "aurora",
				callback = function()
					-- 给 aurora 补一个默认背景
					vim.api.nvim_set_hl(0, "Normal", { bg = "#1a1b26" })
					vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1a1b26" })
				end,
			})
		end,
		config = function()
			vim.cmd.colorscheme("aurora")
			vim.api.nvim_set_hl(0, "@number", { fg = "#e933e3" })

			vim.api.nvim_set_hl(0, "Search", { fg = "#c0caf5", bg = "#3d59a1", bold = true })
			vim.api.nvim_set_hl(0, "IncSearch", { fg = "#15161e", bg = "#FF5555", bold = true })
			vim.api.nvim_set_hl(0, "CurSearch", { fg = "#15161e", bg = "#FF5555", bold = true })
		end,
	},
}
