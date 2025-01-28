require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'lua_ls', 'solargraph', 'svelte', 'html', 'ts_ls', 'vuels', 'pylsp' },
})

local on_attach = function(client, bufnr)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { })

  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})

  if client.server_capabilities.documentSymbolProvider then
    require('nvim-navic').attach(client, bufnr)
  end
end

require('copilot').setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
  filetypes = { gitcommit = true }
})

require('copilot_cmp').setup()

local cmp = require('cmp')

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Rplace,
      select = true
    }),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })
  }),
  sources = cmp.config.sources(
  {
    { name = 'copilot', group_index = 2 },
    { name = 'nvim_lsp', group_index = 2 },
    { name = 'vsnip', group_index = 2 }
  },
  {
    { name = 'buffer' }
  })
}


local capabilities = vim.tbl_deep_extend("force",
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities()
)

capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

require('lspconfig').lua_ls.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}

require('lspconfig').solargraph.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

require('lspconfig').svelte.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

require('lspconfig').html.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

require('lspconfig').ts_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

require('lspconfig').pylsp.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

require('lspconfig').vuels.setup {
  capabilities = capabilities,
  on_attach = on_attach
}
