function vim.getVisualSelection()
  vim.cmd 'noau normal! "vy"'
  local text = vim.fn.getreg 'v'
  vim.fn.setreg('v', {})

  text = string.gsub(text, '\n', '')
  if #text > 0 then
    return text
  else
    return ''
  end
end

return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'debugloop/telescope-undo.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
    },
    version = false,
    keys = {
      {
        '<leader>le',
        function()
          require('telescope.builtin').diagnostics()
        end,
        mode = 'n',
        desc = 'List diagnostics',
      },
      { '<leader>ut', ':Telescope undo<CR>', mode = 'n', desc = 'Undo tree' },
      config = function()
        local telescope = require 'telescope'
        telescope.setup {
          extensions = {
            fzf = {
              fuzzy = true, -- false will only do exact matching
              override_generic_sorter = true, -- override the generic sorter
              override_file_sorter = true, -- override the file sorter
              case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
              -- the default case_mode is "smart_case"
            },
          },
          defaults = {
            layout_config = {
              width = 0.8,
              prompt_position = 'top',
              preview_cutoff = 120,
              horizontal = { mirror = false },
              vertical = { mirror = false },
            },
            layout_strategy = 'horizontal',
            winblend = 0,
            selection_strategy = 'reset',
            sorting_strategy = 'ascending',
            prompt_prefix = '   ',
            selection_caret = '󰜴 ',
            path_display = { 'smart' },
            file_ignore_patterns = { '.git/', 'node_modules' },
          },
        }
        telescope.load_extension 'undo'
        require('telescope').load_extension 'fzf'
      end,
    },
  },
  {
    'ethanholz/nvim-lastplace',
    config = function()
      require('nvim-lastplace').setup {}
    end,
  },
  {
    'iamcco/markdown-preview.nvim',
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
}
