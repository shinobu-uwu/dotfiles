return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
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
			require("telescope").load_extension("undo")
		end,
	},
}
