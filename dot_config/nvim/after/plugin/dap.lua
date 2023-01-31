local dap = require('dap')

vim.keymap.set('n', '<leader>tb', function()
    dap.toggle_breakpoint()
end)

dap.adapters.php = {
    type = "executable",
    command = "/home/shinobu/.local/share/nvim/mason/bin/php-debug-adapter",
}

-- TODO: configure everything

local dapui = require("dapui")
dapui.setup()
require("nvim-dap-virtual-text").setup()
