-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

local wk = require 'which-key'
wk.register({
  K = { '<cmd>lua vim.lsp.buf.hover()<cr>', 'Hover doc', silent = true, noremap = true },
  T = { '<cmd>lua vim.diagnostic.open_float(nil, { focus = false })<cr>', 'Open float diagnostics', silent = true },
  g = {
    name = 'Go to',
    d = { '<cmd>lua vim.lsp.buf.definition()<cr>', 'Go to definition', silent = true, noremap = true },
    e = { '<cmd>lua vim.diagnostic.goto_next()<cr>', 'Go to next diagnostic', silent = true, noremap = true },
    E = {
      '<cmd>lua vim.diagnostic.goto_prev()<cr>',
      'Go to previous diagnostic',
      silent = true,
      noremap = true,
    },
  },
}, {})
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('n', '<leader>ww', ':winc w<cr>', { silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
