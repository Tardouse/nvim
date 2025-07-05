local M = {}

local F = {}

local documentation_window_open = false

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
                opts = {
                    use_diagnostic_signs = true,
                    action_keys = {
                        close = "<esc>",
                        previous = "k",
                        next = "j",
                    },
                },
            },
            { 'williamboman/mason.nvim', build = function() vim.cmd([[MasonInstall]]) end },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'j-hui/fidget.nvim', tag = 'legacy' },
            'folke/neodev.nvim',
            'ray-x/lsp_signature.nvim',
            'ldelossa/nvim-dap-projects',
            'airblade/vim-rooter',
            'b0o/schemastore.nvim',
            {
                'laytan/tailwind-sorter.nvim',
                dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
                build = 'cd formatter && npm ci && npm run build',
                opts = {
                    on_save_enabled = true,
                },
            },
        },
        config = function()
            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'bashls', 'pyright', 'biome', 'cssls', 'ts_ls', 'lua_ls',
                    'eslint', 'jsonls', 'html', 'dockerls', 'ansiblels',
                    'terraformls', 'texlab', 'yamlls', 'tailwindcss', 'taplo',
                },
            })

            local lspconfig = require('lspconfig')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local function on_attach(client, bufnr)
                if client.name == 'ts_ls' then
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end
                client.server_capabilities.semanticTokensProvider = nil
                require('plugins.autocomplete').configfunc()
                require('lsp_signature').on_attach(F.signature_config, bufnr)
                vim.diagnostic.config({
                    severity_sort = true,
                    underline = true,
                    signs = true,
                    virtual_text = false,
                    update_in_insert = false,
                    float = true,
                })
                local signs = { Error = '✘', Warn = '▲', Hint = '⚑', Info = '»' }
                for type, icon in pairs(signs) do
                    local hl = 'DiagnosticSign' .. type
                    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
                end
            end

            local server_handlers = {
                ['lua_ls'] = function()
                    require('config.lsp.lua').setup(lspconfig, { on_attach = on_attach, capabilities = capabilities })
                end,
                ['texlab'] = function()
                    local texlab_opts = require('config.lsp.texlab')
                    texlab_opts.on_attach = on_attach
                    texlab_opts.capabilities = capabilities
                    lspconfig.texlab.setup(texlab_opts)
                end,
                ['jsonls'] = function()
                    require('config.lsp.json').setup(lspconfig, { on_attach = on_attach, capabilities = capabilities })
                end,
            }

            local mlsp = require('mason-lspconfig')
            if mlsp.setup_handlers then
                mlsp.setup_handlers({
                    function(server_name)
                        if server_handlers[server_name] then
                            server_handlers[server_name]()
                            return
                        end
                        lspconfig[server_name].setup({ on_attach = on_attach, capabilities = capabilities })
                    end,
                })
            else
                for _, server_name in ipairs(mlsp.get_installed_servers()) do
                    if server_handlers[server_name] then
                        server_handlers[server_name]()
                    else
                        lspconfig[server_name].setup({ on_attach = on_attach, capabilities = capabilities })
                    end
                end
            end

            require('fidget').setup({})
            local defaults = lspconfig.util.default_config
            defaults.capabilities = vim.tbl_deep_extend('force', defaults.capabilities, capabilities)

            require('nvim-dap-projects').search_project_config()

            F.configureDocAndSignature()
            F.configureKeybinds()

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

            lspconfig.yamlls.setup({
                settings = {
                    redhat = { telemetry = { enabled = false } },
                    yaml = {
                        schemaStore = { enable = false, url = '' },
                        validate = false,
                        customTags = {
                            '!fn', '!And', '!If', '!Not', '!Equals', '!Or',
                            '!FindInMap sequence', '!Base64', '!Cidr', '!Ref', '!Sub',
                            '!GetAtt', '!GetAZs', '!ImportValue', '!Select', '!Split',
                            '!Join sequence',
                        },
                    },
                },
            })
        end,
    },
}

F.configureDocAndSignature = function()
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
                        "CursorMoved",
                        "CursorMovedI",
                        "BufHidden",
                        "InsertCharPre",
                        "InsertEnter",
                        "WinLeave",
                        "ModeChanged",
                    },
                })
            end
        end,
        group = group,
    })
end

local documentation_window_open_index = 0
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

F.configureKeybinds = function()
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
            vim.keymap.set('n', '<leader>-', vim.diagnostic.goto_prev, opts)
            vim.keymap.set('n', '<leader>=', vim.diagnostic.goto_next, opts)
        end,
    })
end

return M
