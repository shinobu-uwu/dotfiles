return {
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
