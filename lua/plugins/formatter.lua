return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "ConformInfo" },
		config = function()
			require("conform").setup({
				format_on_save = {
					lsp_fallback = true,
					timeout_ms = 500,
				},
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "isort", "black" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					json = { "prettier" },
					go = { "gofmt" },
				},
				vim.keymap.set({ "n", "v" }, "<leader>ff", function()
					require("conform").format({ async = true, lsp_fallback = true })
				end, { desc = "Format file or range" }),
			})
		end,
	},
}
