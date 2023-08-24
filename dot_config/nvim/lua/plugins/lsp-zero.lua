return {
	{
		"VonHeikemen/lsp-zero.nvim",
		lazy = false,
		branch = "dev-v3",
		config = function()
			local lsp = require("lsp-zero").preset({})

			lsp.on_attach(function(_, bufnr)
				lsp.default_keymaps({ buffer = bufnr })
			end)

			lsp.set_sign_icons({
				error = "✘",
				warn = "▲",
				hint = "⚑",
				info = "",
			})

			lsp.extend_cmp({
				set_format = false,
			})

			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = { "rust_analyzer", "clangd" },
				handlers = {
					lsp.default_setup,
					lua_ls = function()
						require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
					end,
					rust_analyzer = function()
						local opts = {
							dap = {
								adapter = {
									type = "executable",
									command = "lldb",
									name = "rt_lldb",
								},
							},
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
			})

			-- we need to setup these plugins after lsp-zero
			require("flutter-tools").setup({
				capabilities = lsp.get_capabilities(),
			})

			require("clangd_extensions").setup({
				server = {
					cmd = {
						"clangd",
						"--offset-encoding=utf-16",
					},
				},
			})
		end,
	},
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
		},
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local lspkind = require("lspkind")

			cmp.setup({
				preselect = "item",
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				},
				mapping = {
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select_opts),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select_opts),
					["<Enter>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<Tab>"] = nil,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				formatting = {
					fields = { "abbr", "kind" },
					format = lspkind.cmp_format({
						mode = "symbol",
						maxwidth = 100,
						ellipsis_char = "...",
					}),
					sorting = {
						comparators = {
							cmp.config.compare.offset,
							cmp.config.compare.exact,
							cmp.config.compare.score,
							require("cmp-under-comparator").under,
							cmp.config.compare.kind,
							cmp.config.compare.sort_text,
							cmp.config.compare.length,
							cmp.config.compare.order,
						},
					},
				},
			})
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
		dependencies = {
			{ "L3MON4D3/LuaSnip" },
		},
	},
	{ "hrsh7th/cmp-path" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/cmp-nvim-lua" },
	{ "onsails/lspkind.nvim" },
	{ "rafamadriz/friendly-snippets" },
}
