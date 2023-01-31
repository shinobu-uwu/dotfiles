vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use {
        'Mofiqul/dracula.nvim',
        as = 'dracula',
        config = function()
            vim.cmd("colorscheme dracula")
        end
    }
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        }
    }
    use 'lewis6991/impatient.nvim'
    use "windwp/nvim-autopairs"
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use 'simrat39/rust-tools.nvim'
    use 'mfussenegger/nvim-dap'
    use 'folke/which-key.nvim'
    use { 'CRAG666/code_runner.nvim', requires = 'nvim-lua/plenary.nvim' }
    use 'rcarriga/nvim-notify'
    use 'romgrk/barbar.nvim'
    use 'numToStr/Comment.nvim'
    use 'p00f/clangd_extensions.nvim'
    use {
        'saecki/crates.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('crates').setup()
        end,
    }
    use {
        'm-demare/hlargs.nvim',
        requires = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('hlargs').setup()
        end
    }
    use {
        'ethanholz/nvim-lastplace',
        config = function()
            require 'nvim-lastplace'.setup {}
        end
    }
    use "kylechui/nvim-surround"
    use {
        'ghassan0/telescope-glyph.nvim',
        config = function()
            require('telescope').load_extension('glyph')
        end
    }
    use {
        'debugloop/telescope-undo.nvim',
        config = function()
            require('telescope').load_extension('undo')
        end
    }
    use({
        "mcauley-penney/tidy.nvim",
        config = function()
            require("tidy").setup()
        end
    })
    use 'lukas-reineke/indent-blankline.nvim'
    use "glepnir/lspsaga.nvim"
    use 'yamatsum/nvim-cursorline'
    use 'norcalli/nvim-colorizer.lua'
    use { 'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim' }
    use "ahmedkhalf/project.nvim"
    use 'kdheepak/lazygit.nvim'
    use 'lewis6991/gitsigns.nvim'
    use "luukvbaal/statuscol.nvim"
    use 'ThePrimeagen/refactoring.nvim'
    use {
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
    }
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
    use "folke/neodev.nvim"
    use "theHamsta/nvim-dap-virtual-text"
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })
end)
