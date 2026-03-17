local build_on_save_is_enabled = false

local function toggle_build_on_save()
	build_on_save_is_enabled = not build_on_save_is_enabled
	if build_on_save_is_enabled then
		vim.notify("Neovim: Auto-build on save ENABLED", vim.log.levels.INFO, { title = "Texlab" })
	else
		vim.notify("Neovim: Auto-build on save DISABLED", vim.log.levels.INFO, { title = "Texlab" })
	end
end

local function client_with_fn(fn)
	return function()
		local bufnr = vim.api.nvim_get_current_buf()
		local client = vim.lsp.get_clients({ bufnr = bufnr, name = "texlab" })[1]
		if not client then
			return vim.notify(("texlab client not found in bufnr %d"):format(bufnr), vim.log.levels.ERROR)
		end
		fn(client, bufnr)
	end
end

local function buf_build(client, bufnr)
	local win = vim.api.nvim_get_current_win()
	local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
	client.request("textDocument/build", params, function(err, result)
		if err then
			error(tostring(err))
		end
		local texlab_build_status = {
			[0] = "Success",
			[1] = "Error",
			[2] = "Failure",
			[3] = "Cancelled",
		}
		vim.notify("Build " .. texlab_build_status[result.status], vim.log.levels.INFO)
	end, bufnr)
end

local function buf_search(client, bufnr)
	local win = vim.api.nvim_get_current_win()
	local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
	client.request("textDocument/forwardSearch", params, function(err, result)
		if err then
			error(tostring(err))
		end
		local texlab_forward_status = {
			[0] = "Success",
			[1] = "Error",
			[2] = "Failure",
			[3] = "Unconfigured",
		}
		vim.notify("Forward Search " .. texlab_forward_status[result.status], vim.log.levels.INFO)
	end, bufnr)
end

local function buf_cancel_build(client, bufnr)
	client:exec_cmd({ title = "cancel", command = "texlab.cancelBuild" }, { bufnr = bufnr })
	vim.notify("Build cancelled", vim.log.levels.INFO)
end

local function dependency_graph(client)
	client:exec_cmd({ command = "texlab.showDependencyGraph" }, { bufnr = 0 }, function(err, result)
		if err then
			return vim.notify(err.code .. ": " .. err.message, vim.log.levels.ERROR)
		end
		vim.notify("The dependency graph has been generated:\n" .. result, vim.log.levels.INFO)
	end)
end

local function command_factory(cmd)
	local cmd_tbl = {
		Auxiliary = "texlab.cleanAuxiliary",
		Artifacts = "texlab.cleanArtifacts",
		CancelBuild = "texlab.cancelBuild",
	}

	return function(client, bufnr)
		client:exec_cmd({
			title = ("clean_%s"):format(cmd),
			command = cmd_tbl[cmd],
			arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
		}, { bufnr = bufnr }, function(err, _)
			if err then
				vim.notify(("Failed to clean %s files: %s"):format(cmd, err.message), vim.log.levels.ERROR)
			else
				vim.notify(("command %s executed successfully"):format(cmd_tbl[cmd]), vim.log.levels.INFO)
			end
		end)
	end
end

if vim.fn.exists(":TexlabToggleBuildOnSave") == 0 then
	vim.api.nvim_create_user_command("TexlabToggleBuildOnSave", toggle_build_on_save, {
		desc = "Toggle automatic building on save for Texlab (Client-side)",
	})
end

vim.keymap.set("n", "<leader>lt", "<Cmd>TexlabToggleBuildOnSave<CR>", {
	noremap = true,
	silent = true,
	desc = "[L]SP [T]oggle OnSave Build",
})

return {
	cmd = { "texlab" },
	filetypes = { "tex", "plaintex", "bib" },
	root_markers = { ".git", ".latexmkrc", "latexmkrc", ".texlabroot", "texlabroot", "Tectonic.toml" },
	settings = {
		texlab = {
			build = {
				executable = "latexmk",
				args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
				onSave = false,
				forwardSearchAfter = true,
			},
			forwardSearch = {
				executable = "zathura",
				args = { "--synctex-forward", "%l:1:%f", "%p" },
			},
			chktex = { onOpenAndSave = false, onEdit = false },
			diagnosticsDelay = 300,
			latexFormatter = "latexindent",
			latexindent = {
				["local"] = vim.fn.stdpath("config") .. "/lsp/latexindent.yaml",
				modifyLineBreaks = false,
			},
			bibtexFormatter = "texlab",
			formatterLineLength = 80,
		},
	},
	on_attach = function(_, bufnr)
		-- vim.notify("texlab attached to buffer " .. bufnr, vim.log.levels.INFO, {
		--     title = "LSP Notification"
		-- })
		vim.api.nvim_buf_create_user_command(bufnr, "LspTexlabBuild", client_with_fn(buf_build), {
			desc = "Build the current buffer",
		})
		vim.api.nvim_buf_create_user_command(bufnr, "LspTexlabForward", client_with_fn(buf_search), {
			desc = "Forward search from current position",
		})
		vim.api.nvim_buf_create_user_command(bufnr, "LspTexlabCancelBuild", client_with_fn(buf_cancel_build), {
			desc = "Cancel the current build",
		})
		vim.api.nvim_buf_create_user_command(bufnr, "LspTexlabDependencyGraph", client_with_fn(dependency_graph), {
			desc = "Show the dependency graph",
		})
		vim.api.nvim_buf_create_user_command(
			bufnr,
			"LspTexlabCleanArtifacts",
			client_with_fn(command_factory("Artifacts")),
			{
				desc = "Clean the artifacts",
			}
		)

		local map = vim.keymap.set
		local opts = { buffer = bufnr, desc = "" }
		opts.desc = "[L]SP [B]uild"
		map("n", "<leader>lb", "<Cmd>LspTexlabBuild<CR>", opts)
		opts.desc = "[L]SP [S]earch"
		map("n", "<leader>ls", "<Cmd>LspTexlabForward<CR>", opts)

		local augroup = vim.api.nvim_create_augroup("TexlabUserAutoBuildOnSave" .. bufnr, { clear = true })
		vim.api.nvim_create_autocmd("BufWritePost", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				if build_on_save_is_enabled then
					vim.notify("Auto-building document (client-side)...", vim.log.levels.INFO, { title = "Texlab" })
					vim.cmd.LspTexlabBuild()
				end
			end,
		})

		require("lsp_signature").on_attach({
			bind = true,
			handler_opts = { border = "rounded" },
		}, bufnr)
	end,
}
