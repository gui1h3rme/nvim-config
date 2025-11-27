return {
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
      'SmiteshP/nvim-navic',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)

          vim.keymap.set('n', '<Space>f', vim.lsp.buf.format, { desc = "Format code", buffer = ev.buf })

          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition", buffer = ev.buf })
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "Go to implementation", buffer = ev.buf })
          vim.keymap.set('n', 'gr', require('fzf-lua').lsp_references, { desc = "Go to references", buffer = ev.buf })

          vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Show declaration", buffer = ev.buf })
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Show signature', buffer = ev.buf })
          vim.keymap.set('n', '<Space>D', vim.lsp.buf.type_definition, { desc = 'Show type definition', buffer = ev.buf })

          vim.keymap.set('n', '<Space>ca', vim.lsp.buf.code_action, { desc = 'Perform code actions', buffer = ev.buf })
          vim.keymap.set('n', '<Space>rn', vim.lsp.buf.rename, { desc = 'Rename definition', buffer = ev.buf })


          if client.server_capabilities.documentSymbolProvider then
            require('nvim-navic').attach(client, ev.buf)
          end
        end
      })
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

      vim.diagnostic.config({
        virtual_lines = {
          current_line = true
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "󰙎",
            [vim.diagnostic.severity.HINT] = "",
          }
        }
      })

      vim.lsp.config('*', {
        --  capabilities = capabilities,
      })

      vim.lsp.config('lua_ls', {
        --capabilities = capabilities,
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
          'graphql'
        },
      })
    end
  },
}
