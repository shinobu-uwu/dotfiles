return {
	{
		"echasnovski/mini.pairs",
		version = false,
		config = function()
			require("mini.pairs").setup()
		end,
	},
	{
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
        config = function ()
            require('nvim-treesitter.configs').setup({
              context_commentstring = {
                enable = true
              }
            })
        end
    },
    {
        'mrjones2014/nvim-ts-rainbow',
        lazy = true,
        config = function ()
            require("nvim-treesitter.configs").setup {
              rainbow = {
                enable = true,
                extended_mode = true,
                max_file_lines = nil,
                -- TODO: colors = {}, -- table of hex strings
                -- termcolors = {} -- table of colour name strings
              }
            }
        end
    },
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		opts = {
			hooks = {
				pre = function()
					require("ts_context_commentstring.internal").update_commentstring({})
				end,
			},
		},
		config = function(_, opts)
			require("mini.comment").setup(opts)
		end,
	},
	{
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
        config = function ()
            vim.g.code_action_menu_window_border = 'rounded'
        end,
		keys = {
			{ "<M-Enter>", ":CodeActionMenu<CR>", mode = "n", silent = true, desc = "Code action menu" },
		},
	},
    {
        'kdheepak/lazygit.nvim',
        keys = {
            {'<leader>lg', ':LazyGitFilterCurrentFile<CR>', mode = 'n', silent = true, desc = 'LazyGit'}
        }
    },
    {
        "glepnir/lspsaga.nvim",
        event = "BufRead",
        opts = {
            ui = {
                theme = "round",
                title = true,
                border = "rounded",
                winblend = 0,
                expand = "",
                collapse = "",
                preview = " ",
                code_action = "💡",
                diagnostic = "🐞",
                incoming = " ",
                outgoing = " ",
                hover = ' ',
                kind = {},
            },
            lightbulb = {
                enable = true,
                enable_in_insert = true,
                sign = false,
                sign_priority = 40,
                virtual_text = true,
            },
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            {'gr', ':Lspsaga rename ++project<cr>', mode = 'n', desc = 'Rename', silent = true, noremap = true},
            {'gd', ':Lspsaga lsp_finder<cr>', mode = 'n', desc = 'View usages', silent = true, noremap = true},
            {'<leader>o', ':Lspsaga outline<cr>', mode = 'n', desc = 'Code outline', silent = true, noremap = true},
            {'ge', ':Lspsaga diagnostic_jump_next<cr>', mode = 'n', desc = 'Go to next diagnostic', silent = true, noremap = true},
            {'gE', ':Lspsaga diagnostic_jump_prev<cr>', mode = 'n', desc = 'Go to previous diagnostic', silent = true, noremap = true},
            {'K', ':Lspsaga hover_doc<cr>', mode = 'n', desc = 'Hover doc', silent = true, noremap = true},
        }
    },
}
