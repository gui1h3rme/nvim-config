return {
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        event = 'InsertEnter',
      },
      'zbirenbaum/copilot-cmp',
      'SmiteshP/nvim-navic',
    },
    config = function()
      local lsp = require('lspconfig')
      local cmp = require('cmp')

      require('copilot').setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = { gitcommit = true }
      })

      require('copilot_cmp').setup()

      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
        },
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
        sources = cmp.config.sources({
            { name = 'copilot', group_index = 2 },
            { name = 'nvim_lsp', group_index = 2 },
            { name = 'vsnip', group_index = 2 },
            { name = 'neorg', group_index = 2 }
          },{
            { name = 'buffer' },
          }
        )
      })

      local lsp_actions = function(client, buffer)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition"})
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "Go to implementation"})
          vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc = "Go to references" })
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Show declaration" })

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
              capabilites = require('cmp_nvim_lsp').default_capabilities()
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
