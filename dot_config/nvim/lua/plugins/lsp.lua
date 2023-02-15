return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ "williamboman/mason.nvim" }, -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "hrsh7th/cmp-path" }, -- Optional
			{ "saadparwaiz1/cmp_luasnip" }, -- Optional
			{ "hrsh7th/cmp-nvim-lua" }, -- Optional

			-- Snippets
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "rafamadriz/friendly-snippets" }, -- Optional

			-- Icons
			{ "onsails/lspkind.nvim" },
		},
		config = function()
			local lsp = require("lsp-zero")
			local lspkind = require("lspkind")
			local navic = require("nvim-navic")
			lsp.preset("recommended")

			lsp.on_attach(function(client, bufnr)
				navic.attach(client, bufnr)
			end)

			lsp.set_preferences({
				set_lsp_keymaps = false,
				sign_icons = {
					error = "",
					warning = "",
					hint = "",
					info = "",
				},
			})

			vim.diagnostic.config({
				virtual_text = true,
				underline = true,
				signs = true,
				float = {
					show_header = true,
					source = "if_many",
					border = "rounded",
					focusable = false,
				},
				update_in_insert = true,
				severity_sort = true,
			})
			vim.o.updatetime = 150
			vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false })]])

			lsp.setup_nvim_cmp({
				formatting = {
					fields = { "abbr", "kind" },
					format = lspkind.cmp_format(),
				},
			})

			lsp.setup()
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.stylua,
					-- null_ls.builtins.diagnostics.eslint,
					null_ls.builtins.formatting.rustfmt,
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
									filter = function()
										return client.name == "null-ls"
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
