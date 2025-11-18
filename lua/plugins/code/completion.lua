return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      {
        'zbirenbaum/copilot-cmp',
        dependencies = {
          {
            'zbirenbaum/copilot.lua',
            cmd = 'Copilot',
            event = 'InsertEnter',
            opts = {
              suggestion = { enabled = false },
              panel = { enabled = false },
              filetypes = { gitcommit = true }
            }
          }
        }
      }
    },
    config = function()
      local cmp = require('cmp')

      require('copilot_cmp').setup({})

      local mapping = {
        ['<Tab>'] = {
          c = function ()
            if cmp.visible() then
              cmp.select_next_item()
            else
              cmp.complete()
            end
          end
        },
        ['<S-Tab>'] = {
          c = function ()
            if cmp.visible() then
              cmp.select_prev_item()
            else
              cmp.complete()
            end
          end
        },
        ['<C-Down>'] = {
          c = function ()
            if cmp.visible() then
              cmp.select_next_item()
            else
              cmp.complete()
            end
          end
        },
        ['<C-Up>'] = {
          c = function ()
            if cmp.visible() then
              cmp.select_prev_item()
            else
              cmp.complete()
            end
          end
        },
        ['<C-CR>'] = {
          c = cmp.mapping.confirm({ select = false })
        }
      }

      cmp.setup.cmdline('/',{
        mapping = mapping,
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline(':', {
        mapping = mapping,
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' }
            }
          }
        })
      })

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
          ['<C-CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Rplace,
            select = true
          }),
          ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })
        }),
        sources = cmp.config.sources({
          { name = 'copilot',  group_index = 2 },
          { name = 'nvim_lsp', group_index = 2 },
          { name = 'vsnip',    group_index = 2 },
          { name = 'neorg',    group_index = 2 }
        }, {
          { name = 'buffer' },
        }
        )
      })
    end
  }
}
