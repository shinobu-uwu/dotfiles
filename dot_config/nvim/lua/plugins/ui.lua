return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("catppuccin").setup({
				flavour = "macchiato", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = false,
				show_end_of_buffer = false, -- show the '~' characters after the end of buffers
				term_colors = false,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				no_italic = false, -- Force no italic
				no_bold = false, -- Force no bold
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				color_overrides = {},
				custom_highlights = {},
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					telescope = true,
					barbecue = {
						dim_dirname = true,
						bold_basename = true,
						dim_context = false,
					},
					notify = true,
					integration = {
						dap = {
							enabled = true,
							enable_ui = true, -- enable nvim-dap-ui
						},
					},
					which_key = true,
					illuminate = true,
					treesitter = true,
					noice = true,
					mason = true,
					barbar = true,
				},
			})

			-- setup must be called before loading
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	-- {
	-- 	"Mofiqul/dracula.nvim",
	-- 	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	config = function()
	-- 		-- local gutter_fg = "#4B5263"
	-- 		local gutter_fg = "#033E5D"
	-- 		local dracula = require("dracula")
	-- 		dracula.setup({
	-- 			italic_comment = true,
	-- 			overrides = {
	-- 				-- Make floating window more visible aainst default background
	-- 				NormalFloat = { bg = "#2E303F" },
	-- 				-- Add hl for vim-illuminate
	-- 				illuminatedWord = { bg = gutter_fg },
	-- 				illuminatedCurWord = { bg = gutter_fg },
	-- 				IlluminatedWordText = { bg = gutter_fg },
	-- 				IlluminatedWordRead = { bg = gutter_fg },
	-- 				IlluminatedWordWrite = { bg = gutter_fg },
	-- 			},
	-- 		})
	--
	-- 		vim.cmd([[colorscheme dracula]])
	-- 	end,
	-- },
	{ "MunifTanjim/nui.nvim" },
	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader>dn",
				function()
					require("notify").dismiss()
				end,
				mode = "n",
				desc = "Dismiss notifications",
			},
		},
	},
	{
		"folke/noice.nvim",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = true, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
		},
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				filetype_exclude = { "dashboard" },
				space_char_blankline = " ",
				char_highlight_list = {
					"IndentBlanklineIndent1",
					"IndentBlanklineIndent2",
					"IndentBlanklineIndent3",
					"IndentBlanklineIndent4",
					"IndentBlanklineIndent5",
					"IndentBlanklineIndent6",
				},
			})

			vim.cmd([[highlight IndentBlanklineIndent1 guifg=#ff5555 gui=nocombine]])
			vim.cmd([[highlight IndentBlanklineIndent2 guifg=#ffb86c gui=nocombine]])
			vim.cmd([[highlight IndentBlanklineIndent3 guifg=#50fa7b gui=nocombine]])
			vim.cmd([[highlight IndentBlanklineIndent4 guifg=#6272a4 gui=nocombine]])
			vim.cmd([[highlight IndentBlanklineIndent5 guifg=#8be9fd gui=nocombine]])
			vim.cmd([[highlight IndentBlanklineIndent6 guifg=#bd93f9 gui=nocombine]])

			vim.opt.list = true
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({
				-- your personnal icons can go here (to override)
				-- you can specify color or cterm_color instead of specifying both of them
				-- DevIcon will be appended to `name`
				override = {
					zsh = {
						icon = "",
						color = "#428850",
						cterm_color = "65",
						name = "Zsh",
					},
				},
				-- globally enable different highlight colors per icon (default to true)
				-- if set to false all icons will have the default icon's color
				color_icons = true,
				-- globally enable default icons (default to false)
				-- will get overriden by `get_icons` option
				default = true,
			})
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		keys = {
			{ "<M-1>", "<cmd>NvimTreeToggle<CR>", mode = "n" },
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		version = "nightly",
		opts = {
			open_on_tab = true,
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
			filters = {
				dotfiles = true,
			},
			view = {
				adaptive_size = true,
			},
			renderer = {
				group_empty = true,
			},
			update_focused_file = {
				enable = true,
				update_root = false,
			},
			sync_root_with_cwd = true,
			respect_buf_cwd = true,
			diagnostics = {
				enable = true,
				show_on_dirs = true,
				severity = {
					min = vim.diagnostic.severity.ERROR,
				},
			},
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup({})
		end,
	},
	{
		"m-demare/hlargs.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {},
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			local colors = {
				blue = "#8aadf4",
				cyan = "#7dc4e4",
				black = "#181926",
				white = "#cad3f5",
				red = "#ed8796",
				violet = "#c6a0f6",
				grey = "#363a4f",
			}

			local bubbles_theme = {
				normal = {
					a = { fg = colors.black, bg = colors.violet },
					b = { fg = colors.white, bg = colors.grey },
					c = { fg = colors.black, bg = colors.black },
				},

				insert = { a = { fg = colors.black, bg = colors.blue } },
				visual = { a = { fg = colors.black, bg = colors.cyan } },
				replace = { a = { fg = colors.black, bg = colors.red } },

				inactive = {
					a = { fg = colors.white, bg = colors.black },
					b = { fg = colors.white, bg = colors.black },
					c = { fg = colors.black, bg = colors.black },
				},
			}

			require("lualine").setup({
				options = {
					theme = bubbles_theme,
					component_separators = "|",
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = {
						{ "mode", separator = { left = "" }, right_padding = 2 },
					},
					lualine_b = { "filename", "branch" },
					lualine_c = { "fileformat" },
					lualine_x = {},
					lualine_y = { "filetype", "progress" },
					lualine_z = {
						{ "location", separator = { right = "" }, left_padding = 2 },
					},
				},
				inactive_sections = {
					lualine_a = { "filename" },
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = { "location" },
				},
				tabline = {},
				extensions = {},
			})
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-web-devicons").setup()
		end,
		keys = {
			{
				"<leader>xx",
				":TroubleToggle document_diagnostics<CR>",
				mode = "n",
				silent = true,
				desc = "Toggle file diagnostics window",
			},
			{
				"<leader>xX",
				":TroubleToggle workspace_diagnostics<CR>",
				mode = "n",
				silent = true,
				desc = "Toggle workspace diagnostics window",
			},
		},
	},
	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				under_cursor = false,
				filetypes_denylist = {
					"NvimTree",
				},
			})
		end,
	},
	{
		"Tummetott/reticle.nvim",
		lazy = false,
		init = function()
			vim.api.nvim_create_autocmd("BufWinEnter", {
				pattern = "*",
				callback = function()
					vim.opt.cursorline = true
				end,
				once = false,
			})
			vim.opt.cursorline = true
		end,
	},
	{
		"romgrk/barbar.nvim",
		lazy = false,
		dependencies = { "nvim-web-devicons" },
		keys = {
			{
				"gt",
				"<Cmd>BufferNext<CR>",
				mode = "n",
				silent = true,
				desc = "Go to next buffer",
				noremap = true,
			},
			{
				"gT",
				"<Cmd>BufferPrevious<CR>",
				mode = "n",
				silent = true,
				desc = "Go to previous buffer",
				noremap = true,
			},
			{
				"g<",
				"<Cmd>BufferMovePrevious<CR>",
				mode = "n",
				silent = true,
				desc = "Moves current buffer to the left",
				noremap = true,
			},
			{
				"g>",
				"<Cmd>BufferMoveNext<CR>",
				mode = "n",
				silent = true,
				desc = "Moves current buffer to the right",
				noremap = true,
			},
			{
				"1gt",
				"<Cmd>BufferGoto 1<CR>",
				mode = "n",
				silent = true,
				desc = "Go to buffer 1",
				noremap = true,
			},
			{
				"2gt",
				"<Cmd>BufferGoto 2<CR>",
				mode = "n",
				silent = true,
				desc = "Go to buffer 2",
				noremap = true,
			},
			{
				"3gt",
				"<Cmd>BufferGoto 3<CR>",
				mode = "n",
				silent = true,
				desc = "Go to buffer 3",
				noremap = true,
			},
			{
				"4gt",
				"<Cmd>BufferGoto 4<CR>",
				mode = "n",
				silent = true,
				desc = "Go to buffer 4",
				noremap = true,
			},
			{
				"5gt",
				"<Cmd>BufferGoto 5<CR>",
				mode = "n",
				silent = true,
				desc = "Go to buffer 5",
				noremap = true,
			},
			{
				"6gt",
				"<Cmd>BufferGoto 6<CR>",
				mode = "n",
				silent = true,
				desc = "Go to buffer 6",
				noremap = true,
			},
			{
				"7gt",
				"<Cmd>BufferGoto 7<CR>",
				mode = "n",
				silent = true,
				desc = "Go to buffer 7",
				noremap = true,
			},
			{
				"8gt",
				"<Cmd>BufferGoto 8<CR>",
				mode = "n",
				silent = true,
				desc = "Go to buffer 8",
				noremap = true,
			},
			{
				"9gt",
				"<Cmd>BufferGoto 9<CR>",
				mode = "n",
				silent = true,
				desc = "Go to buffer 9",
				noremap = true,
			},
			{
				"0gt",
				"<Cmd>BufferLast<CR>",
				mode = "n",
				silent = true,
				desc = "Go to last buffer",
				noremap = true,
			},
			{
				"<leader>q",
				"<Cmd>BufferClose<CR>",
				mode = "n",
				silent = true,
				desc = "Close buffer",
				noremap = true,
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
			require("scrollbar.handlers.gitsigns").setup()
		end,
	},
	{
		"sunjon/shade.nvim",
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			theme = "catppuccin",
		},
	},
	{
		"lukas-reineke/virt-column.nvim",
		config = true,
	},
	{
		"petertriho/nvim-scrollbar",
		config = true,
	},
	{
		"mortepau/codicons.nvim",
	},
}
