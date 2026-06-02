-- Bold current line number
vim.opt.cursorline = true
vim.cmd("hi CursorLineNr cterm=bold")

-- Enable Mouse
vim.opt.mouse = a

-- Bold current line number
vim.opt.guicursor = { 'n-v-c-sm:hor20-blinkon1','i-ci-ve:ver25-blinkon1','r-cr-o:block-blinkon1' }

	-- Input timeouts
vim.opt.timeoutlen=300
vim.opt.ttimeoutlen=0

-- Set title
vim.opt.titlestring='%F'
vim.opt.titlelen=256
vim.opt.title=true

-- Basic Setup
vim.opt.encoding = 'utf-8'
vim.opt.laststatus=3
vim.opt.breakindent=true
vim.opt.linebreak=true
vim.opt.smartindent=true
vim.opt.number=true
vim.opt.relativenumber=true
vim.opt.readonly=true

-- Toggle editing mode  
vim.opt.readonly=true

-- Always center cursor
--vim.api.nvim_create_autocmd("BufWinEnter", {
--	pattern = "*",
--	callback = function()
--		vim.opt.scrolloff=999
--		vim.opt_local.display = "lastline"
--	end,
--})
vim.opt.fillchars:append({ eob = "~" })

-- Keep cursor always vertically centered
--vim.opt.scrolloff = 999
-- Auto-recenter cursor on movement
vim.api.nvim_create_autocmd({ "CursorMoved", "BufWinEnter", "WinScrolled" }, {
    pattern = "*",
    callback = function()
		vim.cmd("normal! zz")
    end,
})

-- White space Handing
vim.api.nvim_set_keymap('i','<Tab>','<Tab>',{})
vim.opt.list=true
vim.opt.listchars={ eol='¬',tab='│·',trail='·',nbsp='·' }
vim.opt.tabstop=3
vim.opt.softtabstop=3
vim.opt.shiftwidth=3
vim.opt.backspace={'indent', 'eol', 'start'}
vim.opt.smarttab=true
--retab

-- Remove trailing whitespace

-- Search 
vim.opt.incsearch=true
vim.opt.ignorecase=true

-- Finding Files
vim.opt.path:append {"**"}
vim.opt.wildmenu=true
vim.opt.wildignore:append { "*.aux", "*.log", "*.out", "*.pdf" }
vim.opt.wildignorecase=true

-- Setting default tex flavor
vim.g.tex_flavor="latex"
vim.g.tex_no_error="true"

