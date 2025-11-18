return {
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
      'SmiteshP/nvim-navic',
    },
    config = function()
      local on_attach_callback = function(client, buffer)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "Go to implementation" })
        vim.keymap.set('n', 'gr', require('fzf-lua').lsp_references, { desc = "Go to references" })

        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Show declaration" })
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Show signature' })
        vim.keymap.set('n', '<Space>D', vim.lsp.buf.type_definition, { desc = 'Show type definition' })

        vim.keymap.set('n', '<Space>ca', vim.lsp.buf.code_action, { desc = 'Perform code actions' })
        vim.keymap.set('n', '<Space>rn', vim.lsp.buf.rename, { desc = 'Rename definition' })
        vim.keymap.set('n', '<Space>f', function ()
          vim.lsp.buf.format({
            async = true,
            timeout_ms = 10000,
          })
        end, { desc = 'Format code' })

          if client.server_capabilities.documentSymbolProvider then
            require('nvim-navic').attach(client, buffer)
          end
      end

      vim.lsp.config('*', {
        capabilites = require('cmp_nvim_lsp').default_capabilities(),
        on_attach = on_attach_callback
      })

      vim.lsp.config('lua_ls', {
        capabilites = require('cmp_nvim_lsp').default_capabilities(),
        on_attach = on_attach_callback,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            }
          }
        }
      })

      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'lua_ls',
          'solargraph',
          'svelte',
          'html',
          'ts_ls',
          'vuels',
          'pylsp',
          'graphql',
          'csharp_ls'
        },
      })
    end
  },
}
