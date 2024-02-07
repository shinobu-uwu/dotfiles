return {
  {
    'm-demare/hlargs.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {},
  },
  {
    'RRethy/vim-illuminate',
    config = function()
      require('illuminate').configure {
        under_cursor = false,
        filetypes_denylist = {
          'NvimTree',
        },
      }
    end,
  },
  {
    'petertriho/nvim-scrollbar',
    config = true,
  },
  { 'onsails/lspkind.nvim' },
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = true,
    keys = {
      {
        '<M-2>',
        function()
          require('oil').open()
        end,
        mode = 'n',
      },
    },
  },
  {
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    version = '*',
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {},
  },
}
