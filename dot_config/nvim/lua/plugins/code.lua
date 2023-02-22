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
		config = function()
			require("nvim-treesitter.configs").setup({
				context_commentstring = {
					enable = true,
				},
			})
		end,
	},
	{
		"mrjones2014/nvim-ts-rainbow",
		lazy = true,
		config = function()
			require("nvim-treesitter.configs").setup({
				rainbow = {
					enable = true,
					extended_mode = true,
					max_file_lines = nil,
					-- TODO: colors = {}, -- table of hex strings
					-- termcolors = {} -- table of colour name strings
				},
			})
		end,
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
		config = function()
			vim.g.code_action_menu_window_border = "rounded"
		end,
		keys = {
			{ "<M-Enter>", ":CodeActionMenu<CR>", mode = "n", silent = true, desc = "Code action menu" },
		},
	},
	{
		"kdheepak/lazygit.nvim",
		keys = {
			{ "<leader>lg", ":LazyGitFilterCurrentFile<CR>", mode = "n", silent = true, desc = "LazyGit" },
		},
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
				hover = " ",
				kind = {},
			},
			lightbulb = {
				enable = true,
				enable_in_insert = true,
				sign = false,
				sign_priority = 40,
				virtual_text = true,
			},
			symbol_in_winbar = {
				enable = false,
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{
				"gd",
				":Lspsaga lsp_finder<cr>",
				mode = "n",
				desc = "View usages",
				silent = true,
				noremap = true,
			},
			{
				"<leader>o",
				":Lspsaga outline<cr>",
				mode = "n",
				desc = "Code outline",
				silent = true,
				noremap = true,
			},
			{
				"ge",
				":Lspsaga diagnostic_jump_next<cr>",
				mode = "n",
				desc = "Go to next diagnostic",
				silent = true,
				noremap = true,
			},
			{
				"gE",
				":Lspsaga diagnostic_jump_prev<cr>",
				mode = "n",
				desc = "Go to previous diagnostic",
				silent = true,
				noremap = true,
			},
			{ "K", ":Lspsaga hover_doc<cr>", mode = "n", desc = "Hover doc", silent = true, noremap = true },
		},
	},
	{
		"simrat39/rust-tools.nvim",
		config = function()
			local function on_attach(client, buffer) end

			local opts = {
				tools = {
					runnables = {
						use_telescope = true,
					},
					inlay_hints = {
						auto = true,
						show_parameter_hints = false,
						parameter_hints_prefix = "",
						other_hints_prefix = "",
					},
				},
				server = {
					on_attach = on_attach,
					settings = {
						["rust-analyzer"] = {
							checkOnSave = {
								command = "clippy",
							},
						},
					},
				},
			}

			require("rust-tools").setup(opts)
		end,
	},
	{
		"saecki/crates.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup()
		end,
	},
	{
		"p00f/clangd_extensions.nvim",
		config = function()
			require("clangd_extensions").setup()
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-treesitter.configs").setup({
				autotag = {
					enable = true,
				},
			})
		end,
	},
	{
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
		config = function()
			local navic = require("nvim-navic")
			navic.setup({
				icons = {
					File = " ",
					Module = " ",
					Namespace = " ",
					Package = " ",
					Class = " ",
					Method = " ",
					Property = " ",
					Field = " ",
					Constructor = " ",
					Enum = " ",
					Interface = " ",
					Function = " ",
					Variable = " ",
					Constant = " ",
					String = " ",
					Number = " ",
					Boolean = " ",
					Array = " ",
					Object = " ",
					Key = " ",
					Null = " ",
					EnumMember = " ",
					Struct = " ",
					Event = " ",
					Operator = " ",
					TypeParameter = " ",
				},
			})
		end,
	},
	{
		"filipdutescu/renamer.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"gr",
				'<cmd>lua require("renamer").rename()<cr>',
				mode = "n",
				desc = "Rename",
				silent = true,
				noremap = true,
			},
		},
		config = function()
			require("renamer").setup({
				title = "Rename",
				min_width = 30,
				max_width = 80,
			})
		end,
	},
	{
		"nmac427/guess-indent.nvim",
		config = function()
			require("guess-indent").setup({})
		end,
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = { "tpope/vim-dadbod" },
		config = function()
			vim.g.dbs = {
				dev = "mysql://root:12345@172.17.0.2",
			}
			vim.keymap.set("n", "<leader>db", "<cmd>DBUIToggle<cr>")
		end,
	},
}
