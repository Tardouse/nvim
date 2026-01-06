return {
	{
		"hat0uma/csvview.nvim",
		ft = { "csv" },
		---@module "csvview"
		---@type CsvView.Options
		opts = {
			parser = { comments = { "#", "//" } },
			view = {
				display_mode = "border",
			},
			keymaps = {
				textobject_field_inner = { "if", mode = { "o", "x" } },
				textobject_field_outer = { "af", mode = { "o", "x" } },
				jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
				jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
				jump_next_row = { "<Enter>", mode = { "n", "v" } },
				jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
			},
		},
		config = function(_, opts)
			require("csvview").setup(opts)
			require("csvview").enable()
		end,
		cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
	},
}

