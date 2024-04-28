local status, hlslens = pcall(require, 'hlslens')
if not status then return end

hlslens.setup()


local kopts = {noremap = true, silent = true}

vim.api.nvim_set_keymap('n', 'n',
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts)
vim.api.nvim_set_keymap('n', 'N',
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts)
vim.api.nvim_set_keymap('n', '<Leader><Leader>', [[*<Cmd>lua require('hlslens').start()<CR>N]], kopts)

vim.api.nvim_set_keymap('n', '<Leader>l', '<Cmd>noh<CR>', kopts)

local status2, scrollbar_hlslens_handler = pcall(require, 'scrollbar.handlers.search')
if not status2 then return end

scrollbar_hlslens_handler.setup()
