return {
    'gera2ld/ai.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {
        ---- AI's answer is displayed in a popup buffer
        ---- Default behaviour is not to give it the focus because it is seen as a kind of tooltip
        ---- But if you prefer it to get the focus, set to true.
        result_popup_gets_focus = false,
        ---- Override default prompts here, see below for more details
        -- prompts = {},
        ---- Default models for each prompt, can be overridden in the prompt definition
        models = {
            {
                provider = 'gemini',
                model = 'gemini-2.5-flash-lite-preview-06-17',
                result_tpl = '## Gemini\n\n{{output}}',
            },
        },

        --- API keys and relavant config
        gemini = {
            api_key = '',
            model = 'gemini-2.5-flash-lite-preview-06-17',
            -- proxy = '',
        },
    },
    vim.keymap.set({ 'n', 'v' }, '<leader>sw', ':AITranslate<CR>', { silent = true, nowait = true }),
    event = 'VeryLazy',
}
