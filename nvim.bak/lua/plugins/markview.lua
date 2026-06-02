return {
	"OXY2DEV/markview.nvim",
	lazy = false,
	opts = {
		markdown = {
			block_quotes = { wrap = false },
			headings = { org_indent_wrap = false },
			list_items = { wrap = false },
		}
	},
	config = function(_, opts)
		require("markview").setup(opts)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "markdown",
			callback = function()
				local opts = { noremap = true, silent = true, buffer = true }
				-- no wrap for table
				vim.opt_local.wrap = false
				-- basic keymap
				vim.keymap.set("n", "<localleader>t", ":Markview toggle<CR>", opts)
				vim.keymap.set("n", "<localleader>v", ":Markview splitToggle<CR>", opts)
			end,
		})
	end,
};
