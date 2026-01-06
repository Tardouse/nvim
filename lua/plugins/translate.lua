return {
	dir = "/home/jesse/Downloads/translate.nvim",
	name = "translate.nvim",
    cmd = { "Translate", "TranslateToEN", "TranslateToCN", "TranslateToggle" },
	keys = {
		{ "<leader>ts", "<cmd>Translate<cr>", mode = { "n", "v" }, desc = "Translate" },
	},
	opts = {
		backend = "claude", -- openai, gemini, claude, deepseek
		backends = {
			openai = {
				api_key = "xxx",
                url="",
                model="",
			},
			gemini = {
				api_key = "xxx",
                url="",
                model="",
			},
			claude = {
				api_key = "xxx",
                url="",
                model="",
			},
			deepseek = {
				api_key = "xxx",
                url="",
                model="",
			},
		},
		ui = {
			width = 60,
			height = 10,
			border = "rounded",
		},
		config = function(_, opts)
			require("translate").setup(opts)
		end,
	},
}
