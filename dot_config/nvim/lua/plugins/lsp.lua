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
			{ "hrsh7th/nvim-cmp", version = false }, -- Required
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

			vim.opt.signcolumn = "yes"

			lsp.set_preferences({
				set_lsp_keymaps = false,
			})

			vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false })]])

			local cmp = require("cmp")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			lsp.setup_nvim_cmp({
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				formatting = {
					fields = { "abbr", "kind" },
					format = lspkind.cmp_format(),
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

			lsp.skip_server_setup({ "rust_analyzer" })
			lsp.setup()

			vim.diagnostic.config({
				virtual_text = true,
				underline = true,
				signs = false,
				float = {
					show_header = true,
					source = "if_many",
					border = "rounded",
					focusable = false,
				},
				update_in_insert = true,
				severity_sort = true,
				documentation = {
					max_height = 15,
					max_width = 60,
					border = "rounded",
					col_offset = 0,
					side_padding = 1,
					winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None",
					zindex = 1001,
				},
			})
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.rustfmt,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.fixjson,
					null_ls.builtins.diagnostics.eslint_d,
					null_ls.builtins.diagnostics.eslint,
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
	{
		"lukas-reineke/cmp-under-comparator",
	},
}
