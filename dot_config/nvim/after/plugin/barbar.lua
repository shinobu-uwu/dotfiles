local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', 'gT', '<Cmd>BufferPrevious<CR>', opts)
map('n', 'gt', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', 'g<', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', 'g>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '1gt', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '2gt', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '3gt', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '4gt', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '5gt', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '6gt', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '7gt', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '8gt', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '9gt', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '0gt', '<Cmd>BufferLast<CR>', opts)
-- Close buffer
map('n', '<leader>q', '<Cmd>BufferClose<CR>', opts)
