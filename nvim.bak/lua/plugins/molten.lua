-- function recursively find .venv
local function find_venv(dir)
	while dir do
		-- path separator
		local sep = package.config:sub(1,1)
		local venv = dir .. sep .. ".venv"
		if vim.fn.isdirectory(venv) == 1 then return venv end
		local parent = vim.fn.fnamemodify(dir, ":h")
		if parent == dir then return nil end -- if .venv not even in parent
		dir = parent
	end
end

-- function to initalize ipykernel
local function init_kernel()
	local venv_path = find_venv(vim.fn.getcwd())
	if not venv_path then error("No .venv found!") end

	local proj_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t") -- get project folder name

	local kernel_dir = vim.fn.stdpath("data")
							.. package.config:sub(1,1)
							.. "jupyter"
							.. package.config:sub(1,1)
							.. "kernels"
							.. package.config:sub(1,1)
							.. proj_name

	-- check if kernel already exist
	if vim.fn.isdirectory(kernel_dir) == 0 then
		-- create kernel in uv venv
		local cmd = string.format('run python -m ipykernel install --user --name %s',proj_name)
		vim.fn.system(cmd)
	end
	-- initialize Molten with that kernel name
	vim.cmd(("MoltenInit %s"):format(proj_name))
end

return {
	"benlubas/molten-nvim",
	build = ":UpdateRemotePlugins",
	dependencies = "willothy/wezterm.nvim",
	init = function()
		vim.g.molten_output_win_max_height = 20
		vim.g.molten_auto_open_output = false
		vim.g.molten_output_show_more = true
		vim.g.molten_wrap_output = true
		vim.g.molten_image_provider = "wezterm" -- key line
		vim.g.molten_output_virt_lines = true
		vim.gmolten_split_direction = "right"
		vim.g.molten_auto_image_popup = false
	end,
	config = function()
		-- autocmd for keybind to work only in python or ipynb
		-- also automatically setup ipykernel
		--vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		vim.api.nvim_create_autocmd("FileType", {
			--pattern = { "*.py", "*.ipynb" },
			pattern = {"python", "markdown"},
			callback = function()
				local opts = { noremap = true, silent = true, buffer = true }
				-- set keymap to molten init
				vim.keymap.set("n", "<localleader>m", init_kernel, vim.tbl_extend("force", opts, {desc = "Initialize Molten for Python using active venv"}))

				-- basic keymap
				vim.keymap.set("n", "<localleader>rl", ":MoltenEvaluateLine<CR>", opts)
				vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>", opts)
				vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv", opts)
			end,
		})
	end,
}
