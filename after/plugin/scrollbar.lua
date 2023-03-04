local status, scrollbar = pcall(require, 'scrollbar')
if (not status) then return end

local new_colors = {
  blue = '#65D1FF',
  green = '#3EFFDC',
  red = '#FF0000',
  violet = '#FF61EF',
  yellow = '#FFDA7B',
  black = '#000000',
}
scrollbar.setup({
  marks = {
    Search = { color = new_colors.green },
    Error = { color = new_colors.red },
    Warn = { color = new_colors.yellow },
    Info = { color = new_colors.blue },
    Hint = { color = new_colors.violet },
    Misc = { color = new_colors.blue },
  }
})

