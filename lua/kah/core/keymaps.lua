vim.g.mapleader = " "
local keymap = vim.keymap

keymap.set('n', 'x', '"_x')
-- Delete a word backwards
keymap.set('n', 'dw', 'vb"_d')
-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Increment/decrement
keymap.set('n', '<leader>+', '<C-a>')
keymap.set('n', '<leader>-', '<C-x>')
-- Split window
keymap.set('n', 'ss', ':split<Return><C-w>w', { silent = true })
keymap.set('n', 'sv', ':vsplit<Return><C-w>w', { silent = true })
-- Move window
keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sl', '<C-w>l')
-- tab
keymap.set('n', '<leader>to', ':tabnew<CR>')
keymap.set('n', '<leader>tx', ':tabclose<CR>')
keymap.set('n', '<leader>tn', ':tabn<CR>')
keymap.set('n', '<leader>tp', ':tabp<CR>')
keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- plugin keymaps

-- vim-maximizer
keymap.set('n', '<leader>sm', ':MaximizerToggle<CR>')

keymap.set('n', 'j', 'gj')
keymap.set('n', 'k', 'gk')
keymap.set('n', 'H', '0')
keymap.set('n', 'L', '$')
