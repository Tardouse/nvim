-- lua/plugins/lspconfig.lua
-- vim.o.winborder = "rounded"

local M = {}

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
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set('n', '<leader>aw', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', '<leader>ht', ':Trouble<cr>', opts)
            vim.keymap.set('n', '<leader>-', function()
                vim.diagnostic.jump({ count = -1, float = true })
            end, opts)
            vim.keymap.set('n', '<leader>=', function()
                vim.diagnostic.jump({ count = 1, float = true })
            end, opts)
            vim.keymap.set('i', '<C-f>', function()
                vim.lsp.buf.signature_help({
                    focusable = false,
                    zindex    = 60,
                })
            end, opts)
        end,
    })
end

-- Configures diagnostic pop-ups and signature help.
local function configure_doc_and_signature()
    local group = vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
        pattern  = "*",
        group    = group,
        callback = function()
            if not documentation_window_open then
                vim.diagnostic.open_float(0, {
                    scope        = "cursor",
                    focusable    = false,
                    zindex       = 10,
                    close_events = {
                        "CursorMoved", "CursorMovedI", "BufHidden",
                        "InsertCharPre", "InsertEnter", "WinLeave", "ModeChanged",
                    },
                })
            end
        end,
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
        sh = true,
    }

    vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*',
        callback = function()
            if format_on_save_filetypes[vim.bo.filetype] then
                local lineno = vim.api.nvim_win_get_cursor(0)
                vim.lsp.buf.format({
                    async = false,
                    insertSpace = true,
                    tabSize = 4,
                })
                pcall(vim.api.nvim_win_set_cursor, 0, lineno)
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
            { 'williamboman/mason.nvim' },
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

            pcall(function()
                require('neodev').setup({})
            end)

            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local servers = {
                'bashls',
                'pyright',
                'biome',
                'lua_ls',
                'jsonls',
                'html',
                'dockerls',
                'ansiblels',
                'texlab',
                'yamlls',
                'taplo',
                'ts_ls',
            }

            -- Shared on_attach function for all LSP servers.
            local function on_attach(client, bufnr)
                -- Disable formatting for tsserver, as it's often handled by other tools like prettier/eslint.
                if client.name == 'ts_ls' or client.name == 'tsserver' then
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end

                -- Disable semantic tokens for performance, if not needed.
                client.server_capabilities.semanticTokensProvider = nil
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
            -- Setup mason-lspconfig to manage servers.
            require('mason-lspconfig').setup({
                ensure_installed = servers,
            })

            vim.lsp.config('*', {
                on_attach = on_attach,
                capabilities = capabilities,
            })

            local local_lsp_dir = vim.fs.joinpath(vim.fn.stdpath('config'), 'lsp')
            for _, path in ipairs(vim.fn.glob(local_lsp_dir .. '/*.lua', false, true)) do
                local server = vim.fn.fnamemodify(path, ':t:r')
                local ok, local_config = pcall(dofile, path)

                if not ok then
                    vim.notify(string.format('Failed to load local LSP config %s: %s', path, local_config), vim.log.levels.ERROR)
                elseif type(local_config) == 'table' then
                    local server_on_attach = local_config.on_attach
                    local_config.on_attach = function(client, bufnr)
                        on_attach(client, bufnr)
                        if server_on_attach then
                            server_on_attach(client, bufnr)
                        end
                    end
                    vim.lsp.config(server, local_config)
                end
            end

            for _, server in ipairs(servers) do
                vim.lsp.enable(server)
            end

            -- Apply global configurations
            configure_doc_and_signature()
            configure_lsp_keybinds()
            -- configure_format_on_save()
        end,
    },
}

return M
