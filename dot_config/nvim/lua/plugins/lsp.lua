-- local null_ls = require("null-ls")

return {
	{
		"VonHeikemen/lsp-zero.nvim",
		lazy = false,
		branch = "v3.x",
		config = function()
			local lsp = require("lsp-zero").preset({})
			lsp.extend_lspconfig()

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
				handlers = {
					lsp.default_setup,
					lua_ls = function()
						require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
					end,
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
			local autocomplete_group = vim.api.nvim_create_augroup("vimrc_autocompletion", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "sql", "mysql", "plsql" },
				callback = function()
					cmp.setup.buffer({
						sources = {
							{ name = "vim-dadbod-completion" },
							{ name = "buffer" },
							{ name = "vsnip" },
						},
					})
				end,
				group = autocomplete_group,
			})
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
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.gofmt,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.fixjson,
					null_ls.builtins.formatting.autopep8,
					null_ls.builtins.formatting.autoflake,
					null_ls.builtins.formatting.prettier.with({
						extra_filetypes = { "svelte" },
					}),
					null_ls.builtins.formatting.goimports,
					null_ls.builtins.formatting.clang_format,
					null_ls.builtins.formatting.buf,
					null_ls.builtins.diagnostics.eslint_d,
					null_ls.builtins.diagnostics.buf,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({
									bufnr = bufnr,
									filter = function(c)
										return c.name == "null-ls"
									end,
								})
							end,
						})
					end
				end,
			})
		end,
	},
}
