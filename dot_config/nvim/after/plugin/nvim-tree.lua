require("nvim-tree").setup({
    open_on_tab = true,
    actions = {
        open_file = {
            quit_on_open = true
        }
    },
    view = {
        adaptive_size = true,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
    update_focused_file = {
        enable = false,
        update_root = true
    },
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
})

vim.keymap.set("n", "<M-1>", function() vim.cmd("NvimTreeToggle") end)
