return {
    "preservim/tagbar",
	keys = "<leader>t8",
	lazy = true,
	config = function()
		vim.keymap.set("n", "<leader>t8", "<cmd>TagbarToggle<CR>")
	end,
}
