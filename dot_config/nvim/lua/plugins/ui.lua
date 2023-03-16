return {
	{
		"Mofiqul/dracula.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- local gutter_fg = "#4B5263"
			local gutter_fg = "#033E5D"
			local dracula = require("dracula")
			dracula.setup({
				italic_comment = true,
				overrides = {
					-- Make floating window more visible aainst default background
					NormalFloat = { bg = "#2E303F" },
					-- Add hl for vim-illuminate
					illuminatedWord = { bg = gutter_fg },
					illuminatedCurWord = { bg = gutter_fg },
					IlluminatedWordText = { bg = gutter_fg },
					IlluminatedWordRead = { bg = gutter_fg },
					IlluminatedWordWrite = { bg = gutter_fg },
				},
			})

			vim.cmd([[colorscheme dracula]])
		end,
	},
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
		depends = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
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
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- Eviline config for lualine
			-- Author: shadmansaleh
			-- Credit: glepnir
			local lualine = require("lualine")
			local lualine = require("lualine")
			local colors = {
				bg = "#44475a",
				fg = "#f8f8f2",
				yellow = "#f1fa8c",
				cyan = "#8be9fd",
				green = "#50fa7b",
				orange = "#ffb86c",
				violet = "#bd93f9",
				magenta = "#ff79c6",
				blue = "#6272a4",
				red = "#ff5555",
			}

			local conditions = {
				buffer_not_empty = function()
					return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
				end,
				hide_in_width = function()
					return vim.fn.winwidth(0) > 80
				end,
				check_git_workspace = function()
					local filepath = vim.fn.expand("%:p:h")
					local gitdir = vim.fn.finddir(".git", filepath .. ";")
					return gitdir and #gitdir > 0 and #gitdir < #filepath
				end,
			}

			-- Config
			local config = {
				options = {
					-- Disable sections and component separators
					component_separators = "",
					section_separators = "",
					theme = {
						-- We are going to use lualine_c an lualine_x as left and
						-- right section. Both are highlighted by c theme .  So we
						-- are just setting default looks o statusline
						normal = { c = { fg = colors.fg, bg = colors.bg } },
						inactive = { c = { fg = colors.fg, bg = colors.bg } },
					},
				},
				sections = {
					-- these are to remove the defaults
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					-- These will be filled later
					lualine_c = {},
					lualine_x = {},
				},
				inactive_sections = {
					-- these are to remove the defaults
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					lualine_c = {},
					lualine_x = {},
				},
			}

			-- Inserts a component in lualine_c at left section
			local function ins_left(component)
				table.insert(config.sections.lualine_c, component)
			end

			-- Inserts a component in lualine_x ot right section
			local function ins_right(component)
				table.insert(config.sections.lualine_x, component)
			end

			ins_left({
				function()
					return "▊"
				end,
				color = { fg = colors.blue }, -- Sets highlighting of component
				padding = { left = 0, right = 1 }, -- We don't need space before this
			})

			ins_left({
				-- mode component
				function()
					return ""
				end,
				color = function()
					-- auto change color according to neovims mode
					local mode_color = {
						n = colors.red,
						i = colors.green,
						v = colors.blue,
						[""] = colors.blue,
						V = colors.blue,
						c = colors.magenta,
						no = colors.red,
						s = colors.orange,
						S = colors.orange,
						[""] = colors.orange,
						ic = colors.yellow,
						R = colors.violet,
						Rv = colors.violet,
						cv = colors.red,
						ce = colors.red,
						r = colors.cyan,
						rm = colors.cyan,
						["r?"] = colors.cyan,
						["!"] = colors.red,
						t = colors.red,
					}
					return { fg = mode_color[vim.fn.mode()] }
				end,
				padding = { right = 1 },
			})

			ins_left({
				-- filesize component
				"filesize",
				cond = conditions.buffer_not_empty,
			})

			ins_left({
				"filename",
				cond = conditions.buffer_not_empty,
				color = { fg = colors.magenta, gui = "bold" },
			})

			ins_left({ "location" })

			ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })

			ins_left({
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " " },
				diagnostics_color = {
					color_error = { fg = colors.red },
					color_warn = { fg = colors.yellow },
					color_info = { fg = colors.cyan },
				},
			})

			-- Insert mid section. You can make any number of sections in neovim :)
			-- for lualine it's any number greater then 2
			ins_left({
				function()
					return "%="
				end,
			})

			ins_left({
				-- Lsp server name .
				function()
					local msg = "No Active Lsp"
					local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
					local clients = vim.lsp.get_active_clients()
					if next(clients) == nil then
						return msg
					end
					for _, client in ipairs(clients) do
						local filetypes = client.config.filetypes
						if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
							return client.name
						end
					end
					return msg
				end,
				icon = " LSP:",
				color = { fg = "#ffffff", gui = "bold" },
			})

			-- Add components to right sections
			ins_right({
				"o:encoding", -- option component same as &encoding in viml
				fmt = string.upper, -- I'm not sure why it's upper case either ;)
				cond = conditions.hide_in_width,
				color = { fg = colors.green, gui = "bold" },
			})

			ins_right({
				"fileformat",
				fmt = string.upper,
				icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
				color = { fg = colors.green, gui = "bold" },
			})

			ins_right({
				"branch",
				icon = "",
				color = { fg = colors.violet, gui = "bold" },
			})

			ins_right({
				"diff",
				-- Is it me or the symbol for modified us really weird
				symbols = { added = " ", modified = " ", removed = " " },
				diff_color = {
					added = { fg = colors.green },
					modified = { fg = colors.orange },
					removed = { fg = colors.red },
				},
				cond = conditions.hide_in_width,
			})

			ins_right({
				function()
					return "▊"
				end,
				color = { fg = colors.blue },
				padding = { left = 1 },
			})

			-- Now don't forget to initialize lualine
			lualine.setup(config)
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
		opts = {},
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
