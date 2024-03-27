return {
  {
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
      local null_ls = require 'null-ls'

      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.gofmt,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.fixjson,
          null_ls.builtins.formatting.autopep8,
          null_ls.builtins.formatting.autoflake,
          null_ls.builtins.formatting.prettierd.with {
            extra_filetypes = { 'svelte' },
          },
          null_ls.builtins.formatting.goimports,
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.formatting.buf,
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.diagnostics.buf,
        },
        on_attach = function(client, bufnr)
          if client.supports_method 'textDocument/formatting' then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format {
                  bufnr = bufnr,
                  filter = function(c)
                    return c.name == 'null-ls'
                  end,
                }
              end,
            })
          end
        end,
      }
    end,
  },
}
