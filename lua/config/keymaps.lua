local map = function(modes, lhs, rhs, opts)
  vim.keymap.set(modes, lhs, rhs, vim.tbl_deep_extend('force', { silent = true }, opts))
end

local key = function(keystroke)
  return vim.api.nvim_replace_termcodes(keystroke, true, false, true)
end

local press = function(content)
  return vim.api.nvim_feedkeys(content, 'n', true)
end

vim.g.mapleader = ' '

-- Find
map('n', '<Leader>f', '', { desc = 'Search' })
map('n', '<Leader>ff', ':FzfLua files<CR>', { desc = 'Files' })
map('n', '<Leader>fg', ':FzfLua live_grep_glob<CR>', { desc = 'Grep' })
map('n', '<Leader>fr', ':FzfLua resume<CR>', { desc = 'Resume' })
map('n', '<Leader>fp', ':ProjectFzf<CR>', { desc = 'Projects' })

-- Find Selection
map('v', '<Leader>f', 'y:/<C-r>0/', { desc = 'Search Selection', silent = false })
map('v', '<Leader>fr', 'y:%s/<C-r>0//g<Left><Left>', { desc = 'Replace', silent = false })

-- Find inside Selection
map('v', '<Leader>F', [[:/\\%V]], { desc = 'Search inside Selection', silent = false })
map('v', '<Leader>Fr', function()
    press(':s/' .. vim.fn.getreg('0') .. '//g' .. key('<Left>') .. key('<Left>'))
  end
  ,
  { desc = 'Replace', silent = false })

-- Git
map('n', '<Leader>g', ':Git<CR>', { desc = 'Git' })
map('n', '<Leader>gb', ':FzfLua git_branches<CR>', { desc = 'Branches' })
map('n', '<Leader>gB', ':Gitsigns blame<CR>', { desc = 'Blame' })
map('n', '<Leader>gp', ':Git pull<CR>', { desc = 'Pull' })
map('n', '<Leader>gP',
  function()
    press(':Git push origin ' .. vim.fn.system([[git branch --show-current | tr -d '\n']]))
  end, { desc = 'Push', silent = false })

-- Test
map('n', '<Leader>t', ':TestNearest<CR>', { desc = 'Test' })
map('n', '<Leader>tf', ':TestFile<CR>', { desc = 'File' })
map('n', '<Leader>ts', ':TestSuite<CR>', { desc = 'Suite' })
map('n', '<Leader>tl', ':TestLast<CR>', { desc = 'Last' })
map('n', '<Leader>tv', ':TestVisit<CR>', { desc = 'Visit' })
map('n', '<Leader>tc', ':TestClass<CR>', { desc = 'Class' })

-- Debugger
map('n', '<Leader>d', ':DapContinue<CR>', { desc = 'Debbug' })
map('n', '<Leader>d/', ':DapToggleBreakpoint<CR>', { desc = '[?] Breakpoint' })

-- Yank
map('n', 'yp', [[:lua vim.fn.setreg('+', vim.fn.expand('%.'))<CR>]], { desc = 'Path' })
map('n', 'yP', [[:lua vim.fn.setreg('+', vim.fn.expand('%.') .. ":" .. vim.api.nvim_win_get_cursor(0)[1])<CR>]],
  { desc = 'Line Number' })
map({ 'v', 'x' }, 'Y', '"+y', { desc = 'Yank' })

-- Paste
map('v', 'pt', '<Cmd> execute "ToggleTermSendVisualSelection " . v:count1 . "" <CR>', { desc = 'Paste on Terminal' })
map({ 'v', 'x' }, 'P', '"+p', { desc = 'Paste' })

-- Navigation
map('n', '<C-w><Left>', '<C-w>h', { desc = '← Switch' })
map('n', '<C-w><Down>', '<C-w>j', { desc = '↓ Switch' })
map('n', '<C-w><Up>', '<C-w>k', { desc = '↑ Switch' })
map('n', '<C-w><Right>', '<C-w>l', { desc = '→ Switch' })

map('n', '<C-q>', ':q!<CR>', { desc = 'Quit' })
map('n', '<C-w>', ':w!<CR>', { desc = 'Write' })
map('n', '<C-e>', ':wq!<CR>', { desc = 'Write and Quit' })

map('n', '<C-=>', '<C-w>+', { desc = '+ Height' })
map('n', '<C-->', '<C-w>-', { desc = '- Height' })
map('n', '<C-.>', '<C-w>>', { desc = '+ Width' })
map('n', '<C-,>', '<C-w><', { desc = '- Width' })

map('n', '<ESC>', ':nohlsearch<CR>', { desc = '[Esc] Clear Highlight' })

-- Fugitive
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'fugitive' },
  callback = function()
    if not vim.g.fugitive_snr then
      for line in vim.api.nvim_exec('scriptnames', true):gmatch("[^\n]+") do
        local snr = line:gmatch("(%d+)")
        if line:match("autoload/fugitive") then
          vim.g.fugitive_snr = snr() .. '_'
        end
      end
    end

    map('n', 'c', ':Git commit<CR>', { desc = 'Commit', buffer = true })
    map('n', 'ce', ':Git commit --amend<CR>', { desc = 'Commit Edit', buffer = true })
    map('n', 'q', '<C-w>q', { desc = 'Quit', buffer = true })

    local function fugitive_map(mode, keys, cmd, desc)
      map(mode, keys, ':<C-U>execute <SNR>' .. vim.g.fugitive_snr .. cmd .. '<CR>',
        { desc = desc, buffer = true, silent = true })
    end

    fugitive_map('x', 's', [[Do('Toggle',1)]], 'Stage Toggle')
    fugitive_map('n', 's', [[Do('Toggle',0)]], 'Stage Toggle')
    fugitive_map('x', 'r', [[StageDelete(line("'<"), line("'>"), v:count)]], 'Remove')
    fugitive_map('n', 'r', [[StageDelete(line('.'), 0, v:count)]], 'Remove')
    fugitive_map('x', 'e', [[StageInline('toggle', line("'<"), line("'>") - line("'<") + 1)]], 'Expand')
    fugitive_map('n', 'e', [[StageInline('toggle', line('.'), v:count)]], 'Expand')
  end
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = { 'fugitive://*', 'oil://*' },
  callback = function()
    if package.loaded['which-key'] then
      require('which-key').show({
        global = false,
      })
    end
  end
})


---- Terminal
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = { 'term://*' },
  callback = function()
    map('t', '<ESC>', [[ <C-\><C-n> ]], { buffer = 0 })
  end
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    map('n', '<Leader>l', vim.lsp.buf.format, { desc = "Lint", buffer = ev.buf })

    map('n', 'gd', ':FzfLua lsp_definitions<CR>', { desc = "Definitions", buffer = ev.buf })
    map('n', 'gD', ':FzfLua lsp_typedefs<CR>', { desc = "Definitions", buffer = ev.buf })
    map('n', 'gr', ':FzfLua lsp_references<CR>', { desc = "References", buffer = ev.buf })
    map('n', 'gs', ':FzfLua lsp_document_symbols<CR>', { desc = "Document Symbols", buffer = ev.buf })
    map('n', 'gS', ':FzfLua lsp_live_workspace_symbols<CR>', { desc = "Workspace Symbols", buffer = ev.buf })
    map('n', 'gS', ':FzfLua lsp_implementations<CR>', { desc = "Implementations", buffer = ev.buf })
    map('n', 'gh', ':FzfLua lsp_document_diagnostics<CR>', { desc = "Implementations", buffer = ev.buf, noremap = true })

    map('n', 'gH', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
    end, { desc = 'Toogle Hints', noremap = true })

    map('n', 'K', function()
      vim.lsp.buf.hover({ border = 'rounded' })
    end, { desc = "Expand", buffer = ev.buf, noremap = true })

    map('n', '<C-s>', function()
      vim.lsp.signature({ border = 'rounded' })
    end, { desc = "Signature" })

    map('n', '<Leader>ca', vim.lsp.buf.code_action, { desc = 'Actions', buffer = ev.buf })
    map('n', '<Leader>cR', vim.lsp.buf.rename, { desc = 'Rename', buffer = ev.buf })


    if client.server_capabilities.documentSymbolProvider then
      require('nvim-navic').attach(client, ev.buf)
    end
  end
})
