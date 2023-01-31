require("indent_blankline").setup({
    show_current_context_start = true,
    filetype_exclude = { "dashboard" },
    space_char_blankline = " ",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
})

vim.cmd [[highlight IndentBlanklineIndent1 guifg=#ff5555 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#ffb86c gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#50fa7b gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#6272a4 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#8be9fd gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#bd93f9 gui=nocombine]]

vim.opt.list = true
