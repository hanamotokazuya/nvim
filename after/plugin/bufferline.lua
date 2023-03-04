local status, bufferline = pcall(require, 'bufferline')
if (not status) then return end

local opts = {
  options = {
    separator_style = 'slant',
    always_show_bufferline = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    color_icons = true,
    diagnostics = 'nvim_lsp',
    diagnostics_update_in_insert = true,
  }
}

bufferline.setup(opts)

vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})
