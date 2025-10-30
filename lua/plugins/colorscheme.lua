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
		--     vim.cmd.colorscheme "tokyonight-night"
		-- end,
	},
    {
        "catppuccin/nvim", 
        lazy = false,
        name = "catppuccin", 
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("catppuccin-mocha") --catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
        end,
    }
	-- {
	-- 	"ray-x/aurora",
	-- 	init = function()
	-- 		vim.g.aurora_italic = 1
	-- 		vim.g.aurora_transparent = 1
	-- 		vim.g.aurora_bold = 0

	-- 		vim.api.nvim_create_autocmd("ColorScheme", {
	-- 			pattern = "aurora",
	-- 			callback = function()
	-- 				-- 给 aurora 补一个默认背景
	-- 				vim.api.nvim_set_hl(0, "Normal", { bg = "#1a1b26" })
	-- 				vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1a1b26" })
	-- 			end,
	-- 		})
	-- 	end,
	-- 	config = function()
	-- 		vim.cmd.colorscheme("aurora")
	-- 		vim.api.nvim_set_hl(0, "@number", { fg = "#e933e3" })

	-- 		vim.api.nvim_set_hl(0, "Search", { fg = "#c0caf5", bg = "#3d59a1", bold = true })
	-- 		vim.api.nvim_set_hl(0, "IncSearch", { fg = "#15161e", bg = "#FF5555", bold = true })
	-- 		vim.api.nvim_set_hl(0, "CurSearch", { fg = "#15161e", bg = "#FF5555", bold = true })
	-- 	end,
	-- },
}
