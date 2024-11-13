return {
	{
		"mbbill/undotree",
		keys = { "tu" },
		config = function()
			vim.cmd([[
			noremap tu :UndotreeToggle<CR>
		]])
		end
	}
}
