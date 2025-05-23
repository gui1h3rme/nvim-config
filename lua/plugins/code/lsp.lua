return {
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
      'SmiteshP/nvim-navic',
    },
    config = function()
      local lsp = require('lspconfig')

      local lsp_actions = function(client, buffer)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "Go to implementation" })
        vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc = "Go to references" })

        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Show declaration" })
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Show signature' })
        vim.keymap.set('n', '<Space>D', vim.lsp.buf.type_definition, { desc = 'Show type definition' })

        vim.keymap.set('n', '<Space>ca', vim.lsp.buf.code_action, { desc = 'Perform code actions' })
        vim.keymap.set('n', '<Space>rn', vim.lsp.buf.rename, { desc = 'Rename definition' })
        vim.keymap.set('n', '<Space>f', vim.lsp.buf.format, { desc = 'Format code' })

        if client.server_capabilities.documentSymbolProvider then
          require('nvim-navic').attach(client, buffer)
        end
      end

      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = {
          'lua_ls',
          'solargraph',
          'svelte',
          'html',
          'ts_ls',
          'vuels',
          'pylsp'
        },
        handlers = {
          function(server)
            lsp[server].setup({
              capabilites = require('cmp_nvim_lsp').default_capabilities(),
              on_attach = lsp_actions
            })
          end,
          ['lua_ls'] = function()
            lsp.lua_ls.setup({
              capabilites = require('cmp_nvim_lsp').default_capabilities(),
              on_attach = lsp_actions,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { 'vim' }
                  }
                }
              }
            })
          end
        }
      })
    end
  },
}
