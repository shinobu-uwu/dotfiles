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
		config = function()
			require("nvim-treesitter.configs").setup({
				context_commentstring = {
					enable = true,
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
				":lua vim.diagnostic.goto_next()<cr>",
				mode = "n",
				desc = "Go to next diagnostic",
				silent = true,
				noremap = true,
			},
			{
				"gE",
				":lua vim.diagnostic.goto_prev()<cr>",
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
								command = { "clippy", "format" },
							},
							diagnostic = {
								enable = true,
								disabled = { "unresolved-proc-macro" },
								enableExperimental = true,
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
		"smjonas/inc-rename.nvim",
		keys = {
			{
				"gr",
				function()
					return ":IncRename " .. vim.fn.expand("<cword>")
				end,
				mode = "n",
				desc = "Rename",
				silent = true,
				noremap = true,
				expr = true,
			},
		},
		config = true,
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
	{
		"ThePrimeagen/refactoring.nvim",
		keys = {
			{
				"<leader>xv",
				[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
				mode = "v",
				silent = true,
				desc = "Extract variable",
				noremap = true,
				expr = false,
			},
			{
				"<leader>xm",
				[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
				mode = "v",
				silent = true,
				desc = "Extract method",
				noremap = true,
				expr = false,
			},
		},
		config = function()
			require("refactoring").setup({
				prompt_func_return_type = {
					php = true,
				},
				prompt_func_param_type = {
					php = true,
				},
			})
		end,
	},
	{
		"michaelb/sniprun",
		build = "bash ./install.sh",
	},
	{
		"CRAG666/code_runner.nvim",
		keys = {
			{
				"<leader>rr",
				":RunCode<CR>",
				mode = "n",
				silent = true,
				desc = "Run",
				noremap = true,
				expr = false,
			},
		},
		opts = {
			filetype = {
				rust = "cargo run",
			},
		},
	},
}
