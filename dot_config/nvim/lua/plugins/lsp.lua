return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            { 'williamboman/mason.nvim' }, -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' }, -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'hrsh7th/cmp-path' }, -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional
            { 'hrsh7th/cmp-nvim-lua' }, -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' }, -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional

            -- Icons
            { 'onsails/lspkind.nvim' }
        },
        config = function()
            local lsp = require('lsp-zero')
            local lspkind = require("lspkind")
            lsp.preset('recommended')

            lsp.set_preferences({
                set_lsp_keymaps = false,
                sign_icons = {
                    error = '',
                    warning = '',
                    hint = '',
                    info = '',
                }
            })

            vim.diagnostic.config({
                virtual_text = true,
            })

            lsp.setup_nvim_cmp({
                formatting = {
                    fields = { 'menu', 'abbr', 'kind' },
                    format = lspkind.cmp_format(),
                },
            })

            lsp.setup()
        end
    },
}
