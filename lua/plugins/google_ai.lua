return {
	"kiddos/gemini.nvim",
	lazy = false,
	config = function()
		require("gemini").setup({
			model_config = {
				completion_delay = 1000,
				model_id = "gemini-2.5-flash-preview-04-17",
				temperature = 0.2,
				top_k = 20,
				max_output_tokens = 8196,
				response_mime_type = 'text/plain',
			},
			chat_config = {
				enabled = true,
			},
			hints = {
				enabled = true,
				hints_delay = 2000,
				insert_result_key = '<S-Tab>',
				get_prompt = function(node, bufnr)
					local code_block = vim.treesitter.get_node_text(node, bufnr)
					local filetype = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
					local prompt = [[
Instruction: Use 1 or 2 sentences to describe what the following %s function does:

```%s
%s
```]]
					prompt = prompt:format(filetype, filetype, code_block)
					return prompt
				end,
			},
			completion = {
				enabled = true,
				blacklist_filetypes = { 'help', 'qf', 'json', 'yaml', 'toml' },
				blacklist_filenames = { '.env' },
				completion_delay = 600,
				move_cursor_end = false,
				insert_result_key = '<S-Tab>',
				can_complete = function()
					return vim.fn.pumvisible() ~= 1
				end,
				get_system_text = function()
					return "You are a coding AI assistant that autocomplete user's code."
						.. "\n* Your task is to provide code suggestion at the cursor location marked by <cursor></cursor>."
						.. '\n* Do not wrap your code response in ```'
				end,
				get_prompt = function(bufnr, pos)
					local filetype = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
					local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
					local line, col = pos[1], pos[2]
					local target = lines[line] or ''
					lines[line] = target:sub(1, col) .. '<cursor></cursor>' .. target:sub(col + 1)
					local code = table.concat(lines, '\n')
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ':.')
					local prompt = string.format(
						'Below is the content of a %s file `%s`:\n```%s\n%s\n```\n\nSuggest the most likely code at <cursor></cursor>.',
						filetype, filename, filetype, code
					)
					return prompt
				end,
			},
			instruction = {
				enabled = true,
				-- menu_key = '<C-o>',
				prompts = {
					{
						name = 'Unit Test',
						command_name = 'GeminiUnitTest',
						menu = 'Unit Test 🚀',
						get_prompt = function(lines, bufnr)
							local code = table.concat(lines, '\n')
							local ft = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
							return string.format(
								'Context:\n\n```%s\n%s\n```\n\nObjective: Write unit test for the above snippet of code',
								ft, code
							)
						end,
					},
					{
						name = 'Code Review',
						command_name = 'GeminiCodeReview',
						menu = 'Code Review 📜',
						get_prompt = function(lines, bufnr)
							local code = table.concat(lines, '\n')
							local ft = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
							return string.format(
								'Context:\n\n```%s\n%s\n```\n\nObjective: Do a thorough code review for the following code.\nProvide detailed explanation and sincere comments.',
								ft, code
							)
						end,
					},
					{
						name = 'Code Explain',
						command_name = 'GeminiCodeExplain',
						menu = 'Code Explain',
						get_prompt = function(lines, bufnr)
							local code = table.concat(lines, '\n')
							local ft = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
							return string.format(
								'Context:\n\n```%s\n%s\n```\n\nObjective: Explain the following code.\nProvide detailed explanation and sincere comments.',
								ft, code
							)
						end,
					},
				},
			},
			task = {
				enabled = true,
				get_system_text = function()
					return 'You are an AI assistant that helps user write code.\nYour output should be a code diff for git.'
				end,
				get_prompt = function(bufnr, user_prompt)
					local buffers = vim.api.nvim_list_bufs()
					local contents = {}
					for _, b in ipairs(buffers) do
						if vim.api.nvim_buf_is_loaded(b) then
							local lines = vim.api.nvim_buf_get_lines(b, 0, -1, false)
							local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(b), ':.')
							table.insert(contents,
								string.format('`%s`:\n```%s\n%s\n```', name,
									vim.api.nvim_get_option_value('filetype', { buf = b }), table.concat(lines, '\n')))
						end
					end
					local current = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ':.')
					return table.concat(contents, '\n\n') ..
						string.format('\n\nCurrent Opened File: %s\n\nTask: %s', current, user_prompt)
				end,
			},
		})
	end,
}
