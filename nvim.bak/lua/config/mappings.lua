-- Leader
vim.g.mapleader = ";"

vim.g.maplocalleader = "'"

-- Term mode
vim.keymap.set('t', '<leader><Esc>', '<C-\\><C-n>')

-- Fixing Scroll
vim.keymap.set('n', '<ScrollWheelUp>', 'k')
vim.keymap.set('n', '<ScrollWheelDown>', 'j')
vim.keymap.set('i', '<ScrollWheelUp>', '<C-O>k')
vim.keymap.set('i', '<ScrollWheelDown>', '<C-O>j')

-- Clipboard Paste Keys
vim.keymap.set('n', '<leader>y', '"+yy')
vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('n', '<leader>P', '"+P')
vim.keymap.set('v', '<leader>y', '"+yy')
vim.keymap.set('v', '<leader>p', '"+p')
vim.keymap.set('v', '<leader>P', '"+P')

-- Open Scratchpad Terminal in working directory
vim.keymap.set('n', 'T', ':silent !bspc_focus_on.sh vim_term <Bar><Bar> { bspc config split_ratio 0.69; bspc node --presel-dir ~south; urxvtc -name vim_term; bspc config split_ratio 0.5; } <CR>', {silent = true})

-- Toggle editing mode
vim.keymap.set('n', '<leader>r', function() vim.opt.readonly=not(vim.opt.readonly:get()) end)

-- View files
--vim.keymap.set('n', '<leader>e', ':view ')

-- Page up/down
vim.keymap.set('n', '<leader>d', '<C-d><CR>')
vim.keymap.set('n', '<leader>u', '<C-u><CR>')

-- Create new split and switch to it
vim.keymap.set('n', '<leader>v', '<C-w>v<C-w>l')
vim.keymap.set('n', '<leader>s', '<C-w>s<C-w>j')

-- Close split
vim.keymap.set('n', '<leader>q', '<C-w>c')

-- Easier movement in split windows
vim.keymap.set('n', '<leader>h', '<C-w>h')
vim.keymap.set('n', '<leader>j', '<C-w>j')
vim.keymap.set('n', '<leader>k', '<C-w>k')
vim.keymap.set('n', '<leader>l', '<C-w>l')

-- Spell check
vim.keymap.set('n', '<C-s>', ':setlocal spell! spelllang=en_us<CR>')
vim.keymap.set('i', '<C-s>', '<C-o>:setlocal spell! spelllang=en_us<CR>')

-- Sacing Shortcut
vim.keymap.set('n', 'zz', ':w<CR>')

-- Buffer switching
vim.keymap.set('n', 'S-h', ':bprevious<CR>')
vim.keymap.set('n', 'S-l', ':bnext<CR>')

