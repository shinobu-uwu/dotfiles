return {
	{
		"windwp/nvim-autopairs",
		config = true,
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
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = function()
			require("Comment").setup({
				pre_hook = function()
					require("ts_context_commentstring.internal").update_commentstring({})
				end,
			})
		end,
	},
	{
		"aznhe21/actions-preview.nvim",
		config = function()
			vim.keymap.set({ "v", "n" }, "<M-Enter>", require("actions-preview").code_actions)
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
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
		config = true,
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
		"kndndrj/nvim-dbee",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		build = function()
			require("dbee").install()
		end,
		config = function()
			require("dbee").setup(--[[optional config]])
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
				go = "go run .",
			},
		},
	},
	{
		"mfussenegger/nvim-dap",
		keys = {
			{
				"<leader>tb",
				function()
					require("dap").toggle_breakpoint()
				end,
				mode = "n",
				silent = true,
				desc = "Toggle breakpoint",
				noremap = true,
				expr = false,
			},
			config = function()
				local dap = require("dap")
				dap.adapters.php = {
					type = "executable",
					command = "bash",
					args = { "/home/shinobu/.local/share/nvim/mason/bin/php-debug-adapter" },
				}
			end,
		},
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		keys = {
			{
				"<leader>td",
				function()
					require("dapui").toggle()
				end,
				mode = "n",
				silent = true,
				desc = "Toggle breakpoint",
				noremap = true,
				expr = false,
			},
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")

			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			local sign = vim.fn.sign_define

			sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
			sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
		end,
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
	{
		"akinsho/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
		setup = true,
	},
	{
		"github/copilot.vim",
		setup = function()
			vim.g.copilot_filetypes = { markdown = false }
		end,
	},
}
