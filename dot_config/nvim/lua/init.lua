require("deploy")
require("set")
require("remaps")

vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])
