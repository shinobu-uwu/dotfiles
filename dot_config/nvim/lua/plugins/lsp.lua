return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v1.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required
            { "williamboman/mason.nvim" }, -- Optional
            { "williamboman/mason-lspconfig.nvim" }, -- Optional

            -- Autocompletion
            { "hrsh7th/nvim-cmp" }, -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "hrsh7th/cmp-path" }, -- Optional
            { "saadparwaiz1/cmp_luasnip" }, -- Optional
            { "hrsh7th/cmp-nvim-lua" }, -- Optional

            -- Snippets
            { "L3MON4D3/LuaSnip" }, -- Required
            { "rafamadriz/friendly-snippets" }, -- Optional

            -- Icons
            { "onsails/lspkind.nvim" },
        },
        config = function()
            local lsp = require("lsp-zero")
            local lspkind = require("lspkind")
            lsp.preset("recommended")

            lsp.set_preferences({
                set_lsp_keymaps = false,
                sign_icons = {
                    error = "",
                    warning = "",
                    hint = "",
                    info = "",
                },
            })

            vim.diagnostic.config({
                virtual_text = true,
                underline = true,
                signs = true,
                float = {
                    show_header = true,
                    source = "if_many",
                    border = "rounded",
                    focusable = false,
                },
                update_in_insert = false, -- default to false
                severity_sort = false, -- default to false
            })
            vim.o.updatetime = 150
            vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false })]])

            lsp.setup_nvim_cmp({
                formatting = {
                    fields = { "abbr", "kind" },
                    format = lspkind.cmp_format(),
                },
            })

            lsp.setup()
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.diagnostics.eslint,
                    null_ls.builtins.formatting.rustfmt,
                },
            })
        end,
    },
}
