return {
	"gelguy/wilder.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"romgrk/fzy-lua-native",
        "nixprime/cpsm",
	},
	config = function()
		local wilder = require("wilder")
		-- -- auto pick a color as accent_fg --
		-- local function get_first_hl_fg(groups, fallback)
		-- 	for _, group in ipairs(groups) do
		-- 		local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
		-- 		if ok and hl and hl.fg then
		-- 			return string.format("#%06x", hl.fg)
		-- 		end
		-- 	end
		-- 	return fallback
		-- end

		-- local accent_fg = get_first_hl_fg({
		-- 	"DiagnosticInfo",
		-- 	"Special",
		-- 	"Function",
		-- 	"Keyword",
		-- 	"Identifier",
		-- }, "#7aa2f7")
		-- -----------------------------

		wilder.setup({
			modes = { ":", "/", "?" },
			next_key = "<C-j>",
			previous_key = "<C-k>",
		})

		wilder.set_option("pipeline", {
			wilder.branch(
				wilder.python_file_finder_pipeline({
					file_command = function(ctx, arg)
						if string.find(arg, ".") ~= nil then
							return { "fd", "-tf", "-H" }
						else
							return { "fd", "-tf" }
						end
					end,
					dir_command = { "fd", "-td" },
					filters = { "fuzzy_filter" },
				}),
				wilder.substitute_pipeline({
					pipeline = wilder.python_search_pipeline({
						skip_cmdtype_check = 1,
						pattern = wilder.python_fuzzy_pattern({
							start_at_boundary = 0,
						}),
					}),
				}),
				wilder.cmdline_pipeline({
					fuzzy = 2,
					fuzzy_filter = wilder.lua_fzy_filter(),
				}),
				{
					wilder.check(function(ctx, x)
						return x == ""
					end),
					wilder.history(),
				},
				wilder.python_search_pipeline({
					pattern = wilder.python_fuzzy_pattern({
						start_at_boundary = 0,
					}),
				})
			),
		})
		wilder.set_option(
			"renderer",
			wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
				border = "rounded",
				empty_message = wilder.popupmenu_empty_message_with_spinner(),

				highlighter = {
					wilder.lua_fzy_highlighter(),
				},

				highlights = {
					border = "Normal",
					accent = wilder.make_hl("WilderAccent", "Pmenu", {
						{ a = 1 },
						{ a = 1 },
						{ foreground = "#f4468f" },
						-- { foreground = accent_fg },
					}),
				},

				left = {
					" ",
					wilder.popupmenu_devicons(),
				},

				right = {
					" ",
					wilder.popupmenu_scrollbar(),
				},
			}))
		)
	end,
}
