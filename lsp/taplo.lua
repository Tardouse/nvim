local taplo_shutdown_workaround_group = vim.api.nvim_create_augroup("taplo_force_shutdown_on_quit", { clear = true })

vim.api.nvim_create_autocmd("QuitPre", {
	group = taplo_shutdown_workaround_group,
	desc = "Force-stop taplo before quit to avoid duplicate shutdown requests",
	callback = function()
		for _, client in ipairs(vim.lsp.get_clients({ name = "taplo" })) do
			client:stop(true)
		end
	end,
})

return {
	cmd = { "taplo", "lsp", "stdio" },
	filetypes = { "toml" },
	root_markers = { ".taplo.toml", "taplo.toml", ".git" },
}
