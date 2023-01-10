local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.setup()

-- local sign = function(opts)
--     vim.fn.sign_define(opts.name, {
--         texthl = opts.name,
--         text = opts.text,
--         numhl = ''
--     })
-- end
--
-- sign({ name = 'DiagnosticSignError', text = '' })
-- sign({ name = 'DiagnosticSignWarn', text = '' })
-- sign({ name = 'DiagnosticSignHint', text = '' })
-- sign({ name = 'DiagnosticSignInfo', text = '' })

vim.diagnostic.config({
    virtual_text = false,
    signs = false,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

local luasnip = require('luasnip')
vim.keymap.set("n", "<Tab>", function() luasnip.jump(1) end)
vim.keymap.set("n", "<S-Tab>", function() luasnip.jump(-1) end)
vim.keymap.set("i", "<Tab>", function() luasnip.jump(1) end)
vim.keymap.set("i", "<S-Tab>", function() luasnip.jump(-1) end)
vim.keymap.set("v", "<Tab>", function() luasnip.jump(1) end)
vim.keymap.set("v", "<S-Tab>", function() luasnip.jump(-1) end)
