-- lua/plugins/lspconfig.lua
local M = {}

--[[
Local helper functions.
Formerly in a table `F`, now defined as local functions for better encapsulation.
]]

local documentation_window_open = false
local documentation_window_open_index = 0

-- Shows hover documentation.
-- It uses a timer to prevent the documentation window from staying open permanently.
local function show_documentation()
    documentation_window_open_index = documentation_window_open_index + 1
    local current_index = documentation_window_open_index
    documentation_window_open = true
    vim.defer_fn(function()
        if current_index == documentation_window_open_index then
            documentation_window_open = false
        end
    end, 500)
    vim.lsp.buf.hover()
end

-- Configures keybindings for LSP actions.
-- This function is called once when the plugin is configured.
local function configure_lsp_keybinds()
    vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
            local opts = { buffer = event.buf, noremap = true, nowait = true }
            vim.keymap.set('n', '<leader>hd', show_documentation, opts)
            vim.keymap.set('n', '<c-l>', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', '<leader>hi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<leader>ho', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<leader>hr', vim.lsp.buf.references, opts)
            vim.keymap.set('i', '<c-f>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set('n', '<leader>aw', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', '<leader>ht', ':Trouble<cr>', opts)
            vim.keymap.set('n', '<leader>-', function()
                vim.diagnostic.jump({ count = -1, float = true })
            end, opts)
            vim.keymap.set('n', '<leader>=', function()
                vim.diagnostic.jump({ count = 1, float = true })
            end, opts)
        end,
    })
end

-- Configures diagnostic pop-ups and signature help.
local function configure_doc_and_signature()
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
            focusable = false,
            border = "rounded",
            zindex = 60,
        }
    )

    local group = vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
    vim.api.nvim_create_autocmd({ "CursorHold" }, {
        pattern = "*",
        callback = function()
            if not documentation_window_open then
                vim.diagnostic.open_float(0, {
                    scope = "cursor",
                    focusable = false,
                    zindex = 10,
                    close_events = {
                        "CursorMoved", "CursorMovedI", "BufHidden",
                        "InsertCharPre", "InsertEnter", "WinLeave", "ModeChanged",
                    },
                })
            end
        end,
        group = group,
    })
end

-- Configures format on save functionality.
local function configure_format_on_save()
    local format_on_save_filetypes = {
        json = true,
        go = true,
        lua = true,
        html = true,
        css = true,
        javascript = true,
        typescript = true,
        typescriptreact = true,
        c = true,
        cpp = true,
        objc = true,
        objcpp = true,
        dockerfile = true,
        terraform = false,
        tex = true,
        toml = true,
        python = true,
        sh = true,
    }

    vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*',
        callback = function()
            if format_on_save_filetypes[vim.bo.filetype] then
                local view = vim.fn.winsaveview()
                vim.lsp.buf.format({ async = true })
                vim.fn.winrestview(view)
            end
        end,
    })

    vim.api.nvim_create_autocmd('BufWritePost', {
        pattern = { '*.hcl' },
        callback = function()
            local bufnr = vim.api.nvim_get_current_buf()
            local filename = vim.api.nvim_buf_get_name(bufnr)
            vim.fn.system(string.format('packer fmt %s', vim.fn.shellescape(filename)))
            vim.cmd('edit!')
        end,
    })
end


M.config = {
    {
        'weilbith/nvim-code-action-menu',
        cmd = 'CodeActionMenu',
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                "folke/trouble.nvim",
                opts = { use_diagnostic_signs = true, action_keys = { close = "<esc>", previous = "k", next = "j" } },
            },
            { 'williamboman/mason.nvim',          build = function() vim.cmd([[MasonInstall]]) end },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'j-hui/fidget.nvim',                tag = 'legacy' },
            'folke/neodev.nvim',
            'ray-x/lsp_signature.nvim',
            'ldelossa/nvim-dap-projects',
            'airblade/vim-rooter',
            'b0o/schemastore.nvim',
            {
                'laytan/tailwind-sorter.nvim',
                dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
                build = 'cd formatter && npm ci && npm run build',
                opts = { on_save_enabled = true },
            },
        },
        config = function()
            require('mason').setup({})
            require('fidget').setup({})
            require('nvim-dap-projects').search_project_config()

            local lspconfig = require('lspconfig')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- Shared on_attach function for all LSP servers.
            local function on_attach(client, bufnr)
                -- Disable formatting for tsserver, as it's often handled by other tools like prettier/eslint.
                if client.name == 'ts_ls' or client.name == 'tsserver' then
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end

                -- Disable semantic tokens for performance, if not needed.
                client.server_capabilities.semanticTokensProvider = nil

                -- Attach other plugins' functionality.
                require('plugins.autocomplete').configfunc()
                require('lsp_signature').on_attach({
                    bind = true,
                    handler_opts = { border = "rounded" }
                }, bufnr)
            end

            -- Configure diagnostics
            local signs = { Error = "✘", Warn = "", Hint = "⚑", Info = "" }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            vim.diagnostic.config({
                severity_sort = true,
                underline = true,
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = signs.Error,
                        [vim.diagnostic.severity.WARN] = signs.Warn,
                        [vim.diagnostic.severity.HINT] = signs.Hint,
                        [vim.diagnostic.severity.INFO] = signs.Info,
                    },
                },
                virtual_text = false,
                update_in_insert = false,
                float = true,
            })


            -- Centralized server configurations
            local server_handlers = {
                ['lua_ls'] = function()
                    require('config.lsp.lua').setup(lspconfig, { on_attach = on_attach, capabilities = capabilities })
                end,
                ['texlab'] = function()
                    require('config.lsp.texlab').setup(lspconfig, { on_attach = on_attach, capabilities = capabilities })
                end,
                ['jsonls'] = function()
                    require('config.lsp.json').setup(lspconfig, { on_attach = on_attach, capabilities = capabilities })
                end,
                ['yamlls'] = function()
                    require('config.lsp.yaml').setup(lspconfig, { on_attach = on_attach, capabilities = capabilities })
                end,
            }

            -- Setup mason-lspconfig to manage servers.
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'bashls', 'pyright', 'biome', 'cssls', 'ts_ls', 'lua_ls',
                    'eslint', 'jsonls', 'html', 'dockerls', 'ansiblels',
                    'texlab', 'yamlls', 'tailwindcss', 'taplo',
                },
                handlers = {
                    -- Default handler for servers without custom setup.
                    function(server_name)
                        lspconfig[server_name].setup({
                            on_attach = on_attach,
                            capabilities = capabilities,
                        })
                    end,
                    -- Custom handlers for specific servers.
                    ['lua_ls'] = server_handlers.lua_ls,
                    ['texlab'] = server_handlers.texlab,
                    ['jsonls'] = server_handlers.jsonls,
                    ['yamlls'] = server_handlers.yamlls,
                },
            })

            -- Apply global configurations
            configure_doc_and_signature()
            configure_lsp_keybinds()
            configure_format_on_save()
        end,
    },
}

return M
