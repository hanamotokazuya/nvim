local cmp_status, cmp = pcall(require, 'cmp')
if not cmp_status then return end

local lsp_status, lsp = pcall(require, 'lsp-zero')
if not lsp_status then return end

local lspkind_status, lspkind = pcall(require, 'lspkind')
if not lspkind_status then return end

lsp.preset('recommended')

lsp.ensure_installed({
  'tsserver',
  'rust_analyzer',
})

lsp.configure('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = {'vim'},
      },
    },
  },
})
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.abort(),
  ['<CR>'] = cmp.mapping.confirm({ select = false }),
})

lsp.set_preferences({
  sign_icos = { }
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
  formatting = {
    format = lspkind.cmp_format({
      maxwidth = 50,
      ellipsis_char = "...",
    }),
  },
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, noremap = true, silent = true}

  vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga show_line_diagnostics<CR>', opts)
  vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
  vim.keymap.set('n', 'gd', '<Cmd>Lspsaga goto_definition<CR>', opts)
  vim.keymap.set('n', 'gf', '<Cmd>Lspsaga finder<CR>', opts)
  vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)
  vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
  vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set('n', '<leader>vd', '<Cmd>Lspsaga show_buf_diagnostics<CR>', opts)
  vim.keymap.set('n', '[d', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
  vim.keymap.set('n', ']d', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
  vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
  vim.keymap.set('n', 'tt', '<Cmd>Lspsaga term_toggle<CR>', opts)
  vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
end)



lsp.setup()
