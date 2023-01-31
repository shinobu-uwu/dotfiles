local keymap = vim.keymap.set
local saga = require('lspsaga')

saga.setup({
    preview = {
        lines_above = 0,
        lines_below = 10,
    },
    scroll_preview = {
        scroll_down = '<C-f>',
        scroll_up = '<C-b>',
    },
    request_timeout = 2000,
    finder = {
        edit = { 'o', '<CR>' },
        vsplit = 's',
        split = 'i',
        tabe = 't',
        quit = { 'q', '<ESC>' },
    },
    code_action = {
        num_shortcut = true,
        keys = {
            quit = '<ESC>',
            exec = '<CR>',
        },
    },
    lightbulb = {
        enable = true,
        enable_in_insert = true,
        sign = true,
        sign_priority = 40,
        virtual_text = false,
    },
    rename = {
        quit = '<ESC>',
        exec = '<CR>',
        in_select = true,
    },
    outline = {
        win_position = 'right',
        win_with = '',
        win_width = 30,
        show_detail = true,
        auto_preview = true,
        auto_refresh = true,
        auto_close = true,
        custom_sort = nil,
        keys = {
            jump = 'gd',
            expand_collapse = 'u',
            quit = '<ESC>',
        },
    },
    ui = {
        theme = 'round',
        border = 'rounded',
        winblend = 0,
        expand = '',
        collapse = '',
        preview = ' ',
        code_action = '💡',
        diagnostic = '🐞',
        incoming = ' ',
        outgoing = ' ',
        colors = {
            --float window normal bakcground color
            normal_bg = '#44475a',
            title_bg = '#44475a',
            red = '#ff5555',
            magenta = '#b33076',
            orange = '#ffb86c',
            yellow = '#f1fa8c',
            green = '#50fa7b',
            cyan = '#8be9fd',
            blue = '#6272a4',
            purple = '#bd93f9',
            white = '#f8f8f2',
            black = '#282a36',
        },
        kind = {},
    },
    symbol_in_winbar = {
        enable = false,
        separator = ' ',
        hide_keyword = true,
        show_file = true,
        folder_level = 2,
    },
})

keymap("n", "gd", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

-- Code action
keymap({ "n", "v" }, "<M-enter>", "<cmd>Lspsaga code_action<CR>", { silent = true })

-- Rename
keymap({ "n", 'v' }, "gr", "<cmd>Lspsaga rename<CR>", { silent = true })

-- Diagnostic jump can use `<c-o>` to jump back
keymap("n", "ge", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
keymap("n", "gE", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })

-- Only jump to error
keymap("n", "[E", function()
    require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
keymap("n", "]E", function()
    require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })

-- Outline
keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { silent = true })

-- Hover Doc
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
