return {
  {
    'mfussenegger/nvim-lint',
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        go = { 'golangcilint' },
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        svelte = { 'eslint_d' },
        lua = { 'luacheck' },
        json = { 'jsonlint' },
        c = { 'clangtidy' },
      }
      vim.api.nvim_create_autocmd({ 'TextChanged' }, {
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettierd' },
        typescript = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        svelte = { 'prettierd' },
        rust = { 'rustfmt' },
        go = { 'goimports', 'gofmt' },
        c = { 'clang-format' },
        cpp = { 'clang-format' },
        json = { 'fixjson' },
      },
      format_on_save = {
        quiet = true,
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
}
