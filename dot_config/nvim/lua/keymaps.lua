local wk = require("which-key")
wk.register({
	K = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover doc", silent = true, noremap = true },
	g = {
		name = "Go to",
		d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to definition", silent = true, noremap = true },
		e = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Go to next diagnostic", silent = true, noremap = true },
		E = {
			"<cmd>lua vim.diagnostic.goto_prev()<cr>",
			"Go to previous diagnostic",
			silent = true,
			noremap = true,
		},
	},
}, {})
