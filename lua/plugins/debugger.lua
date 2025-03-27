-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)
return {
	-- NOTE: Yes, you can install new plugins here!
	'mfussenegger/nvim-dap',
	-- NOTE: And you can specify dependencies as well
	dependencies = {
		-- Creates a beautiful debugger UI
		'rcarriga/nvim-dap-ui',

		-- Required dependency for nvim-dap-ui
		'nvim-neotest/nvim-nio',

		-- Installs the debug adapters for you
		'williamboman/mason.nvim',
		'jay-babu/mason-nvim-dap.nvim',

		-- Add your own debuggers here
		'leoluz/nvim-dap-go',
	},
	keys = {
		-- Basic debugging keymaps, feel free to change to your liking!
		{
			'<leader>os',
			function()
				require('dap').continue()
			end,
			desc = 'Debug: Start/Continue',
		},
		{
			'<leader>oj',
			function()
				require('dap').step_over()
			end,
			desc = 'Debug: Step Over',
		},
		{
			'<leader>ok',
			function()
				require('dap').step_into()
			end,
			desc = 'Debug: Step Into',
		},
		{
			'<leader>ol',
			function()
				require('dap').step_out()
			end,
			desc = 'Debug: Step Out',
		},
		{
			'<leader>ob',
			function()
				require('dap').toggle_breakpoint()
			end,
			desc = 'Debug: Toggle Breakpoint',
		},
		{
			'<leader>oB',
			function()
				require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
			end,
			desc = 'Debug: Set Breakpoint',
		},
		-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
		{
			'<leader>op',
			function()
				require('dapui').toggle()
			end,
			desc = 'Debug: See last session result.',
		},
	},
	config = function()
		local dap = require 'dap'
		local dapui = require 'dapui'

		require('mason-nvim-dap').setup {
			-- Makes a best effort to setup the various debuggers with
			-- reasonable debug configurations
			automatic_installation = true,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},

			-- You'll need to check that you have the required things installed
			-- online, please don't ask me how to install them :)
			ensure_installed = {
				-- Update this to ensure that you have the debuggers for the langs you want
				'delve',
				'python',
			},
		}

		-- Dap UI setup
		-- For more information, see |:help nvim-dap-ui|
		dapui.setup {
			-- Set icons to characters that are more likely to work in every terminal.
			--    Feel free to remove or use ones that you like more! :)
			--    Don't feel like these are good choices.
			icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
			controls = {
				icons = {
					pause = '⏸',
					play = '▶',
					step_into = '⏎',
					step_over = '⏭',
					step_out = '⏮',
					step_back = 'b',
					run_last = '▶▶',
					terminate = '⏹',
					disconnect = '⏏',
				},
			},
		}

		-- Change breakpoint icons
		-- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
		-- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
		-- local breakpoint_icons = vim.g.have_nerd_font
		--     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
		--   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
		-- for type, icon in pairs(breakpoint_icons) do
		--   local tp = 'Dap' .. type
		--   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
		--   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
		-- end

		dap.listeners.after.event_initialized['dapui_config'] = dapui.open
		dap.listeners.before.event_terminated['dapui_config'] = dapui.close
		dap.listeners.before.event_exited['dapui_config'] = dapui.close

		-- Install golang specific config
		require('dap-go').setup {
			delve = {
				-- On Windows delve must be run attached or it crashes.
				-- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
				detached = vim.fn.has 'win32' == 0,
			},
		}
	end,
}

-- local compile = function()
-- 	vim.cmd("write")
-- 	local filetype = vim.bo.filetype
-- 	if filetype == "cpp" or filetype == "c" then
-- 		os.execute("gcc " .. vim.fn.expand("%") .. " -g -o " .. vim.fn.expand("%<"))
-- 	end
-- end
-- return {
-- 	{
-- 		"mfussenegger/nvim-dap",
-- 		dependencies = {
-- 			{
-- 				"ravenxrz/DAPInstall.nvim",
-- 				config = function()
-- 					local dap_install = require("dap-install")
-- 					dap_install.setup({
-- 						installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
-- 					})
-- 				end
-- 			},
-- 			"theHamsta/nvim-dap-virtual-text",
-- 			{
-- 				"rcarriga/nvim-dap-ui",
-- 				dependencies = {
-- 					"nvim-neotest/nvim-nio",
-- 				},
-- 			},
-- 			"nvim-dap-virtual-text",
-- 			"nvim-telescope/telescope-dap.nvim",
-- 		},
-- 		config = function()
-- 			local dap = require("dap")
-- 			local dapui = require("dapui")

-- 			dapui.setup()
-- 			require("nvim-dap-virtual-text").setup()

-- 			-- dap.listeners.after.event_initialized["dapui_config"] = dapui.open
-- 			-- dap.listeners.before.event_terminated["dapui_config"] = dapui.close
-- 			-- dap.listeners.before.event_exited["dapui_config"] = dapui.close

-- 			local m = { noremap = true }
-- 			vim.keymap.set("n", "<leader>'t", dap.toggle_breakpoint, m)
-- 			vim.keymap.set("n", "<leader>'v", require('dap.ui.widgets').hover, m)
-- 			vim.keymap.set("n", "<leader>'n", function()
-- 				compile()
-- 				dap.continue()
-- 			end, m)
-- 			vim.keymap.set("n", "<leader>'s", dap.step_over, m)
-- 			local widgets = require('dap.ui.widgets')
-- 			vim.keymap.set("n", "<leader>'q", dap.terminate, m)
-- 			vim.keymap.set("n", "<leader>'u", dapui.toggle, m)

-- 			vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
-- 			vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
-- 			vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#ffffff', bg = '#FE3C25' })

-- 			vim.fn.sign_define('DapBreakpoint',
-- 				{ text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
-- 			vim.fn.sign_define('DapBreakpointCondition',
-- 				{ text = 'ﳁ', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
-- 			vim.fn.sign_define('DapBreakpointRejected',
-- 				{ text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
-- 			vim.fn.sign_define('DapLogPoint', {
-- 				text = '',
-- 				texthl = 'DapLogPoint',
-- 				linehl = 'DapLogPoint',
-- 				numhl = 'DapLogPoint'
-- 			})
-- 			vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

-- 			dap.adapters.codelldb = {
-- 				type = 'server',
-- 				port = "${port}",
-- 				executable = {
-- 					command = vim.g.codelldb_path,
-- 					args = { "--port", "${port}" },
-- 				}
-- 			}
-- 			dap.configurations.cpp = {
-- 				{
-- 					name = "Launch file",
-- 					type = "codelldb",
-- 					request = "launch",
-- 					program = function()
-- 						local exe = vim.g.c_debug_program or vim.fn.expand("%:r")
-- 						return vim.fn.getcwd() .. '/' .. exe
-- 					end,
-- 					cwd = '${workspaceFolder}',
-- 					stopOnEntry = false,
-- 				},
-- 			}
-- 			dap.configurations.c = dap.configurations.cpp
-- 			dap.configurations.rust = dap.configurations.cpp

-- 			local dap_install = require("dap-install")
-- 			dap_install.config("codelldb", {})
-- 		end
-- 	}
-- }
