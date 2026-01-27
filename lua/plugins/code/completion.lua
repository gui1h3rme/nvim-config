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

      cmp.setup({
        window = {
          completion = cmp.config.window.bordered({
            border = 'single',
            col_offset = -1,
            scrollbar = false,
            scrolloff = 3,
            winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
          }),
          documentation = cmp.config.window.bordered({
            border = 'solid',
            scrollbar = false,
            winhighlight = 'CursorLine:Visual,Search:None',
          }),
        },
        snippet = {
          expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
          end
        },
        mapping = {
          ['<Tab>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false
          }),
          ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
          ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
          ['<Esc>'] = cmp.mapping.abort()
        },
        sources = cmp.config.sources({
          { name = 'copilot',  group_index = 1 },
          { name = 'nvim_lsp', group_index = 1 },
          { name = 'vsnip',    group_index = 1 },
          { name = 'neorg',    group_index = 1 },
          { name = 'buffer',   group_index = 3 }
        })
      })

      

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = mapping,
        completion = { keyword_length = 1 },
        sources = {
          { name = 'buffer' },
          { name = 'nvim_lsp_document_symbol' },
        }
      })

      cmp.setup.cmdline(':', {
        mapping = mapping,
        formatting = {
          fields = { 'abbr' },
          format = function(_, item)
            item.kind = nil
            return item
          end
        },
        completion = { keyword_length = 1 },
        sources = cmp.config.sources({
          { name = 'path' },
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' }
            }
          }
        }),
        window = {
          completion = {
            side_padding = 1
          }
        }
      })
    end
  }
}
