local status, indent = pcall(require, 'indent_blankline')
if not status then return end

local opts = {
  show_current_context = true,
  show_current_context_start = true,
  char_highlight_list = {
    'IndentBlanklineIndent1',
    'IndentBlanklineIndent2',
    'IndentBlanklineIndent3',
    'IndentBlanklineIndent4',
    'IndentBlanklineIndent5',
    'IndentBlanklineIndent6',
  }
}

indent.setup(opts)
