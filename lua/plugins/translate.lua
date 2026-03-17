return {
    "Tardouse/translate.nvim",
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
				api_key = "sk-ant-oat01-qzOpNk93oiu9EXImfEmparjhYcNkNHmm3onqiiUNOnvv9ivxrGx5SSgV4TNAGt-wLjcduJbAKRq-83QZ8X_7njMR_9H3QAA",
                url="https://code.newcli.com/claude/droid/v1/messages",
                model="claude-sonnet-4-5",
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
