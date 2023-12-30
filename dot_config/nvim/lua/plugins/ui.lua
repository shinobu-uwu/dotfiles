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
				no_underline = false,
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
	{
		"folke/which-key.nvim",
		config = true,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			local highlight = {
				"RainbowRed",
				"RainbowYellow",
				"RainbowBlue",
				"RainbowOrange",
				"RainbowGreen",
				"RainbowViolet",
				"RainbowCyan",
			}

			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			end)

			require("ibl").setup({ indent = { highlight = highlight }, scope = { enabled = false } })
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		keys = {
			{
				"<leader>gb",
				":Gitsigns blame_line<cr>",
				mode = "n",
				silent = true,
				desc = "Git blame current line",
			},
		},
		config = function()
			require("gitsigns").setup()
			require("scrollbar.handlers.gitsigns").setup()
		end,
	},
	{
		"m-demare/hlargs.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {},
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
		"petertriho/nvim-scrollbar",
		config = true,
	},
	{ "nvim-lualine/lualine.nvim", config = true },
	{
		"petertriho/nvim-scrollbar",
		config = true,
	},
	{
		"mortepau/codicons.nvim",
	},
}
