function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end

return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		version = false,
		keys = {
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files()
				end,
				mode = "n",
				desc = "Find files",
			},
			{
				"<leader>ps",
				function()
					require("telescope.builtin").grep_string({ search = vim.fn.input("Find in files: ") })
				end,
				mode = "n",
				desc = "Search everywhere",
			},
			{
				"<leader>ps",
				function()
					require("telescope.builtin").grep_string({ search = vim.getVisualSelection() })
				end,
				mode = "v",
				desc = "Search everywhere",
			},
			{
				"<leader>vu",
				function()
					require("telescope.builtin").lsp_references()
				end,
			},
			{
				"<leader>b",
				function()
					require("telescope.builtin").buffers()
				end,
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"debugloop/telescope-undo.nvim",
		},
		keys = {
			{ "<leader>ut", ":Telescope undo<CR>", mode = "n", desc = "Undo tree" },
		},
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					layout_config = {
						width = 0.8,
						prompt_position = "top",
						preview_cutoff = 120,
						horizontal = { mirror = false },
						vertical = { mirror = false },
					},
					layout_strategy = "horizontal",
					winblend = 0,
					selection_strategy = "reset",
					sorting_strategy = "ascending",
					prompt_prefix = "   ",
					selection_caret = "󰜴 ",
					path_display = { "smart" },
					file_ignore_patterns = { ".git/", "node_modules" },
				},
			})
			telescope.load_extension("undo")
		end,
	},
	{
		"ethanholz/nvim-lastplace",
		config = function()
			require("nvim-lastplace").setup({})
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
}
