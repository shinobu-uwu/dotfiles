require('code_runner').setup({
    filetype = {
        python = "python -u $fileName",
        rust = "cargo run"
    },
})

vim.keymap.set("n", "<leader>rr", function() vim.cmd("RunCode") end)
