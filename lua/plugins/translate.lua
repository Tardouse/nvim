return {
    "Tardouse/translate.nvim",
	-- dir = "/home/jesse/Code/translate.nvim",
	name = "translate.nvim",
    cmd = { "Translate", "TranslateToEN", "TranslateToCN" },
	keys = {
		{ "<leader>ts", "<cmd>Translate<cr>", mode = { "n", "v" }, desc = "Translate" },
	},
	opts = {
		backend = "google", -- google (google translator), openai, gemini, claude, deepseek
        default_target_lang = "zh-CN",
		backends = {
			openai = {
				api_key = "xxx",
                url="",
                model="gpt-5.2",
			},
			gemini = {
				api_key = "xxx",
                url="",
                model="",
			},
			claude = {
				api_key = "",
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
