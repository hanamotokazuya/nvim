local status, saga = pcall(require, 'lspsaga')
if not status then return end

saga.setup({
  code_action = {
    num_shortcut = true,
    show_server_name = false,
    extend_gitsigns = true,
    keys = {
      quit = 'q',
      exec = '<CR>',
    },
  },
  rename = {
    quit = "<C-c>",
    exec = "<CR>",
    mark = "x",
    confirm = "<CR>",
    in_select = true,
  },
})
