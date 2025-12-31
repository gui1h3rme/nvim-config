local map = function(modes, lhs, rhs, opts)
  vim.keymap.set(modes, lhs, rhs, vim.tbl_deep_extend('force', { silent = true }, opts))
end

vim.g.mapleader = ' '

-- create main groups for normal mode
map('n', '<Space>p', '', { desc = '[P]aste' })
map('n', '<Space>f', '', { desc = '[F]ind' })
map('n', '<Space>g', ':Git<CR>', { desc = '[G]it' })
map('n', '<Space>c', '', { desc = '[C]ode' })
map('n', '<Space>t', ':TestNearest<CR>', { desc = '[T]est' })
map('n', '<Space>d', ':DapContinue<CR>', { desc = '[D]ebbug' })

-- copy menu
map('n', '<Space>pp', ':lua vim.fn.setreg(\'+\', vim.fn.expand(\'%.\'))<CR>', { desc = '[P]ath' })
map('n', '<Space>ppl',
  ':lua vim.fn.setreg(\'+\', vim.fn.expand(\'%.\') .. ":" .. vim.api.nvim_win_get_cursor(0)[1])<CR>',
  { desc = '[L]ine Number' })

-- find menu
map('n', '<Space>ff', ':FzfLua files<CR>', { desc = '[F]iles' })
map('n', '<Space>fg', ':FzfLua live_grep_glob<CR>', { desc = '[G]rep' })
map('n', '<Space>fr', ':FzfLua resume<CR>', { desc = '[R]esume' })
map('n', '<Space>fp', ':ProjectFzf<CR>', { desc = '[P]rojects' })

-- git menu
map('n', '<Space>gb', ':FzfLua git_branches<CR>', { desc = '[B]ranches' })
map('n', '<Space>gP', ':Git push origin ' .. vim.fn.system([[git branch --show-current | tr -d '\n']]),
  { desc = '[p]ush', silent = false })
map('n', '<Space>gp', ':Git pull<CR>', { desc = '[P] Pull' })

-- test menu
map('n', '<Space>tf', ':TestFile<CR>', { desc = '[F]ile' })
map('n', '<Space>ts', ':TestSuite<CR>', { desc = '[S]uite' })
map('n', '<Space>tl', ':TestLast<CR>', { desc = '[L]ast' })
map('n', '<Space>tv', ':TestVisit<CR>', { desc = '[V]isit' })
map('n', '<Space>tc', ':TestClass<CR>', { desc = '[C]lass' })

-- debbuger menu
map('n', '<Space>d/', ':DapToggleBreakpoint<CR>', { desc = '[?] Breakpoint' })

-- create main groups for visual mode
map('v', '<Space>f', 'y:/<C-r>0/', { desc = '[F]ind', silent = false })
map('v', '<Space>F', ':/\\%V', { desc = '[F]ind in Selection', silent = false })
map('v', '<Space>p', '', { desc = '[P]aste', silent = false })

-- search menu
map('v', '<Space>fr', 'y:%s/<C-r>0//g<Left><Left>', { desc = '[R]eplace', silent = false })

-- search in selection menu
map('v', '<Space>Fr', [[:s///g<Left><Left><Left>]], { desc = '[R]eplace', silent = false })

-- copy menu
map('v', '<Space>pt', '<Cmd> execute "ToggleTermSendVisualSelection " . v:count1 . "" <CR>',
  { desc = '[P]aste on Terminal' })


-- navigation
map('n', '<C-w><Left>', '<C-w>h', { desc = '[←] Switch' })
map('n', '<C-w><Down>', '<C-w>j', { desc = '[↓] Switch' })
map('n', '<C-w><Up>', '<C-w>k', { desc = '[↑] Switch' })
map('n', '<C-w><Right>', '<C-w>l', { desc = '[→] Switch' })

map('n', '<C-q>', ':q!<CR>', { desc = '[Q]uit' })
map('n', '<C-w>', ':w!<CR>', { desc = '[W]rite' })
map('n', '<C-e>', ':wq!<CR>', { desc = '[E] Write and Quit' })

map('n', '<C-=>', '<C-w>+', { desc = '[+] Height' })
map('n', '<C-->', '<C-w>-', { desc = '[-] Height' })
map('n', '<C-.>', '<C-w>>', { desc = '[+] Width' })
map('n', '<C-,>', '<C-w><', { desc = '[-] Width' })

map({ 'n', 'v', 'x' }, 'Y', '"+y', { desc = '[Y] Yank' })
map({ 'n', 'v', 'x' }, 'P', '"+p', { desc = '[P] Paste' })

---- fugitive
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

    map('n', 'c', ':Git commit<CR>', { desc = '[C]ommit', buffer = true })
    map('n', 'ce', ':Git commit --amend<CR>', { desc = '[C]ommit [E]dit', buffer = true })
    map('n', 'q', '<C-w>q', { desc = '[Q]uit', buffer = true })

    local function fugitive_map(mode, keys, cmd, desc)
      map(mode, keys, ':<C-U>execute <SNR>' .. vim.g.fugitive_snr .. cmd .. '<CR>',
        { desc = desc, buffer = true, silent = true })
    end

    fugitive_map('x', 's', [[Do('Toggle',1)]], '[S]tage Toggle')
    fugitive_map('n', 's', [[Do('Toggle',0)]], '[S]tage Toggle')
    fugitive_map('x', 'r', [[StageDelete(line("'<"), line("'>"), v:count)]], '[R]emove')
    fugitive_map('n', 'r', [[StageDelete(line('.'), 0, v:count)]], '[R]emove')
    fugitive_map('x', 'e', [[StageInline('toggle', line("'<"), line("'>") - line("'<") + 1)]], '[E]xpand')
    fugitive_map('n', 'e', [[StageInline('toggle', line('.'), v:count)]], '[E]xpand')
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


---- terminal
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = { 'term://*' },
  callback = function()
    map('t', '<ESC>', [[ <C-\><C-n> ]], { buffer = 0 })
  end
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    map('n', '<Space>cf', vim.lsp.buf.format, { desc = "[F]ormat", buffer = ev.buf })

    map('n', '<Space>cd', vim.lsp.buf.definition, { desc = "[D]efinition", buffer = ev.buf })
    map('n', '<Space>ci', vim.lsp.buf.implementation, { desc = "[I]mplementation", buffer = ev.buf })
    map('n', '<Space>cr', ':FzfLua lsp_references', { desc = "[R]eferences", buffer = ev.buf })

    map('n', '<Space>ce', vim.lsp.buf.hover, { desc = "[E]xpand", buffer = ev.buf })
    map('n', '<Space>cs', vim.lsp.buf.signature_help, { desc = '[S]ignature', buffer = ev.buf })
    map('n', '<Space>cD', vim.lsp.buf.type_definition, { desc = '[[D]]efinition', buffer = ev.buf })

    map('n', '<Space>ca', vim.lsp.buf.code_action, { desc = '[A]ctions', buffer = ev.buf })
    map('n', '<Space>cR', vim.lsp.buf.rename, { desc = '[[R]]ename', buffer = ev.buf })


    if client.server_capabilities.documentSymbolProvider then
      require('nvim-navic').attach(client, ev.buf)
    end
  end
})
