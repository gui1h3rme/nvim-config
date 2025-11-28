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

          vim.keymap.set('n', '<Space>cf', vim.lsp.buf.format, { desc = "[F]ormat", buffer = ev.buf })

          vim.keymap.set('n', '<Space>cd', vim.lsp.buf.definition, { desc = "[D]efinition", buffer = ev.buf })
          vim.keymap.set('n', '<Space>ci', vim.lsp.buf.implementation, { desc = "[I]mplementation", buffer = ev.buf })
          vim.keymap.set('n', '<Space>cr', ':FzfLua lsp_references', { desc = "[R]eferences", buffer = ev.buf })

          vim.keymap.set('n', '<Space>ce', vim.lsp.buf.hover, { desc = "[E]xpand", buffer = ev.buf })
          vim.keymap.set('n', '<Space>cs', vim.lsp.buf.signature_help, { desc = '[S]ignature', buffer = ev.buf })
          vim.keymap.set('n', '<Space>cD', vim.lsp.buf.type_definition, { desc = '[[D]]efinition', buffer = ev.buf })

          vim.keymap.set('n', '<Space>ca', vim.lsp.buf.code_action, { desc = '[A]ctions', buffer = ev.buf })
          vim.keymap.set('n', '<Space>cR', vim.lsp.buf.rename, { desc = '[[R]]ename', buffer = ev.buf })


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
