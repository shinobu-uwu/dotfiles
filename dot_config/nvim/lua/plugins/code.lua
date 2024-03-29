return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{ "tpope/vim-sleuth" },
	{
		"aznhe21/actions-preview.nvim",
		config = function()
			vim.keymap.set({ "v", "n" }, "<M-Enter>", require("actions-preview").code_actions)
		end,
	},
	{
		"tpope/vim-surround",
	},
	{
		"saecki/crates.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup()
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
		"numToStr/Comment.nvim",
		config = true,
		lazy = false,
	},
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = true,
		keys = {
			{
				"<M-2>",
				function()
					require("oil").open()
				end,
				mode = "n",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		main = "nvim-treesitter.configs",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		opts = {
			ensure_installed = {
				"c",
				"go",
				"lua",
				"python",
				"rust",
				"tsx",
				"javascript",
				"typescript",
				"vimdoc",
				"vim",
				"bash",
			},

			auto_install = true,

			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<c-space>",
					node_incremental = "<c-space>",
					scope_incremental = "<c-s>",
					node_decremental = "<M-space>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]m"] = "@function.outer",
						["]]"] = "@class.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
			},
		},
		build = ":TSUpdate",
	},
	{
		"github/copilot.vim",
	},
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},
}
