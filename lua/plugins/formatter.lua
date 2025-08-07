return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "ConformInfo" },
		config = function()
			local conform = require("conform")

			local format_on_save_enabled = true

			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "isort", "black" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					json = { "prettier" },
					go = { "gofmt" },
					tex = { "latexindent" },
				},
			})

			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function(args)
					if not format_on_save_enabled then
						return
					end

					local bufnr = args.buf
					local formatters = conform.list_formatters(bufnr)
					local formatter_names = vim.tbl_map(function(f)
						return f.name
					end, formatters)
					local used = #formatter_names > 0 and table.concat(formatter_names, ", ") or "LSP"

					vim.notify("Auto formatting with: " .. used, vim.log.levels.INFO, { title = "Conform" })

					conform.format({
						bufnr = bufnr,
						async = false,
						lsp_fallback = true,
						timeout_ms = 500,
					})
				end,
			})

			-- formatter by keys
			vim.keymap.set({ "n", "v" }, "<leader>ff", function()
				local bufnr = vim.api.nvim_get_current_buf()
				local formatters = conform.list_formatters(bufnr)
				local formatter_names = vim.tbl_map(function(f)
					return f.name
				end, formatters)
				local used = #formatter_names > 0 and table.concat(formatter_names, ", ") or "LSP"

				vim.notify("Formatting with: " .. used, vim.log.levels.INFO, { title = "Conform" })

				conform.format({
					async = true,
					lsp_fallback = true,
					timeout_ms = 500,
				})
			end, { desc = "Format file or range" })

			-- toggle format on save
			vim.keymap.set("n", "<leader>fc", function()
				format_on_save_enabled = not format_on_save_enabled
				vim.notify(
					"Format on Save: " .. (format_on_save_enabled and "Enabled" or "Disabled"),
					vim.log.levels.INFO,
					{ title = "Conform" }
				)
			end, { desc = "Toggle format on save" })
		end,
	},
}

-- without notify and switch
-- return {
-- 	{
-- 		"stevearc/conform.nvim",
-- 		event = { "BufReadPre", "BufNewFile" },
-- 		cmd = { "ConformInfo" },
-- 		config = function()
-- 			require("conform").setup({
-- 				format_on_save = {
-- 					lsp_fallback = true,
-- 					timeout_ms = 500,
-- 				},
-- 				formatters_by_ft = {
-- 					lua = { "stylua" },
-- 					python = { "isort", "black" },
-- 					javascript = { "prettier" },
-- 					typescript = { "prettier" },
-- 					json = { "prettier" },
-- 					go = { "gofmt" },
-- 					tex = { "latexindent" },
-- 				},
-- 				vim.keymap.set({ "n", "v" }, "<leader>ff", function()
-- 					require("conform").format({ async = true, lsp_fallback = true })
-- 				end, { desc = "Format file or range" }),
-- 			})
-- 		end,
-- 	},
-- }
