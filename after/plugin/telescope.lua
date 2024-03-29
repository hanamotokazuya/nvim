local telescope_status, telescope = pcall(require, 'telescope')
if not telescope_status then return end

local actions_status, actions = pcall(require, 'telescope.actions')
if not actions_status then return end

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      }
    },
    file_ignore_patterns = {
      "node_modules/.*"
    }
  }
})

local builtin_status, builtin = pcall(require, 'telescope.builtin')
if not builtin_status then return end

vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>w', function()
  builtin.grep_string({ search = vim.fn.input('Grep > ') });
end)
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>j', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>d', builtin.git_status, {})
vim.keymap.set('n', '<leader>c', builtin.git_commits, {})
