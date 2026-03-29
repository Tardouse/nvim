local ensure_installed = {
	"markdown",
	"html",
	"javascript",
	"typescript",
	"tsx",
	"query",
	"dart",
	"java",
	"c",
	"prisma",
	"bash",
	"go",
	"lua",
	"kdl",
	"vim",
	"terraform",
	"dockerfile",
	"yaml",
	"python",
}

local indent_disabled = {
	dart = true,
	yaml = true,
}

local function get_lang(bufnr)
	local filetype = vim.bo[bufnr].filetype
	if filetype == "" or vim.bo[bufnr].buftype ~= "" then
		return nil
	end

	local ok, lang = pcall(vim.treesitter.language.get_lang, filetype)
	if ok and lang and lang ~= "" then
		return lang
	end

	return filetype
end

local function attach(bufnr)
	local lang = get_lang(bufnr)
	if not lang then
		return
	end

	local ok = pcall(vim.treesitter.start, bufnr, lang)
	if not ok then
		return
	end

	if indent_disabled[lang] then
		return
	end

	local has_indents, query = pcall(vim.treesitter.query.get, lang, "indents")
	if has_indents and query then
		vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end
end

local function set_command(name, rhs, opts)
	if vim.fn.exists(":" .. name) == 2 then
		pcall(vim.api.nvim_del_user_command, name)
	end
	vim.api.nvim_create_user_command(name, rhs, opts or {})
end

local function setup_playground_compat()
	local function close_window(bufnr, key)
		local winid = vim.b[bufnr][key]
		if winid and vim.api.nvim_win_is_valid(winid) then
			vim.api.nvim_win_close(winid, true)
			vim.b[bufnr][key] = nil
			return true
		end
		return false
	end

	set_command("TSPlaygroundToggle", function()
		local bufnr = vim.api.nvim_get_current_buf()
		local closed = close_window(bufnr, "dev_inspect")
		close_window(bufnr, "dev_edit")
		if not closed then
			vim.cmd("InspectTree")
		end
	end, { desc = "Toggle treesitter inspector" })

	set_command("TSHighlightCapturesUnderCursor", function()
		vim.cmd("Inspect")
	end, { desc = "Inspect treesitter captures under cursor" })

	set_command("TSCaptureUnderCursor", function()
		vim.cmd("Inspect")
	end, { desc = "Inspect treesitter captures under cursor" })

	set_command("TSNodeUnderCursor", function()
		local bufnr = vim.api.nvim_get_current_buf()
		attach(bufnr)

		local node = vim.treesitter.get_node({ bufnr = bufnr })
		if not node then
			vim.notify("No tree-sitter node under cursor", vim.log.levels.WARN)
			return
		end

		local start_row, start_col, end_row, end_col = node:range()
		vim.notify(
			string.format("%s [%d:%d - %d:%d]", node:type(), start_row + 1, start_col, end_row + 1, end_col),
			vim.log.levels.INFO,
			{ title = "Tree-sitter node" }
		)
	end, { desc = "Show treesitter node under cursor" })
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		priority = 1000,
		build = ":TSUpdate",
		config = function()
			vim.opt.smartindent = false

			local treesitter = require("nvim-treesitter")
			treesitter.setup({})

			setup_playground_compat()

			local group = vim.api.nvim_create_augroup("config_treesitter_attach", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				group = group,
				pattern = "*",
				callback = function(args)
					attach(args.buf)
				end,
			})

			for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
				if vim.api.nvim_buf_is_loaded(bufnr) then
					attach(bufnr)
				end
			end

			vim.schedule(function()
				pcall(treesitter.install, ensure_installed, { summary = true })
			end)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			local tscontext = require("treesitter-context")
			tscontext.setup({
				enable = true,
				max_lines = 1,
				min_window_height = 0,
				line_numbers = true,
				multiline_threshold = 20,
				trim_scope = "outer",
				mode = "cursor",
				separator = nil,
				zindex = 20,
				on_attach = nil,
			})
			vim.keymap.set("n", "[c", function()
				tscontext.go_to_context()
			end, { silent = true })
		end,
	},
}
