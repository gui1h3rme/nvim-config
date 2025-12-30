-- create main groups for normal mode
vim.keymap.set('n', '<Space>p', '', { desc = '[P]aste' })
vim.keymap.set('n', '<Space>f', '', { desc = '[F]ind' })
vim.keymap.set('n', '<Space>g', '', { desc = '[G]it' })
vim.keymap.set('n', '<Space>c', '', { desc = '[C]ode' })
vim.keymap.set('n', '<Space>t', ':TestNearest<CR>', { desc = '[T]est' })
vim.keymap.set('n', '<Space>d', ':DapContinue<CR>', { desc = '[D]ebbug' })

-- copy menu
vim.keymap.set('n', '<Space>pp', ':lua vim.fn.setreg(\'+\', vim.fn.expand(\'%.\'))<CR>', { desc = '[P]ath' })
vim.keymap.set('n', '<Space>ppl',
  ':lua vim.fn.setreg(\'+\', vim.fn.expand(\'%.\') .. ":" .. vim.api.nvim_win_get_cursor(0)[1])<CR>',
  { desc = '[L]ine Number' })

-- find menu
vim.keymap.set('n', '<Space>ff', ':FzfLua files<CR>', { desc = '[F]iles' })
vim.keymap.set('n', '<Space>fg', ':FzfLua live_grep_glob<CR>', { desc = '[G]rep' })
vim.keymap.set('n', '<Space>fr', ':FzfLua resume<CR>', { desc = '[R]esume' })
vim.keymap.set('n', '<Space>fp', ':ProjectFzf<CR>', { desc = '[P]rojects' })

-- git menu
vim.keymap.set('n', '<Space>go', ':Git<CR>', { desc = '[O]pen' })
vim.keymap.set('n', '<Space>gb', ':FzfLua git_branches<CR>', { desc =  '[B]ranches'})

-- test menu
vim.keymap.set('n', '<Space>tf', ':TestFile<CR>', { desc = '[F]ile' })
vim.keymap.set('n', '<Space>ts', ':TestSuite<CR>', { desc = '[S]uite' })
vim.keymap.set('n', '<Space>tl', ':TestLast<CR>', { desc = '[L]ast' })
vim.keymap.set('n', '<Space>tv', ':TestVisit<CR>', { desc = '[V]isit' })
vim.keymap.set('n', '<Space>tc', ':TestClass<CR>', { desc = '[C]lass' })

-- debbuger menu
vim.keymap.set('n', '<Space>d/', ':DapToggleBreakpoint<CR>', { desc = '[?] Breakpoint' })

-- create main groups for visual mode
vim.keymap.set('v', '<Space>f', 'y:/<C-r>0/', { desc = '[F]ind' })
vim.keymap.set('v', '<Space>F', ':/\\%V', { desc = '[F]ind in Selection' })
vim.keymap.set('v', '<Space>p', '', { desc = '[P]aste' })

-- search menu
vim.keymap.set('v', '<Space>fr', 'y:%s/<C-r>0//g<Left><Left>', { desc = '[R]eplace' })

-- search in selection menu
vim.keymap.set('v', '<Space>Fr', [[:s///g<Left><Left><Left>]], { desc = '[R]eplace' })

-- copy menu
vim.keymap.set('v', '<Space>pt', '<Cmd> execute "ToggleTermSendVisualSelection " . v:count1 . "" <CR>',
  { desc = '[P]aste on Terminal' })


-- navigation
vim.keymap.set('n', '<C-w><Left>', '<C-w>h', { desc = '[←] Switch' })
vim.keymap.set('n', '<C-w><Down>', '<C-w>j', { desc = '[↓] Switch' })
vim.keymap.set('n', '<C-w><Up>', '<C-w>k', { desc = '[↑] Switch' })
vim.keymap.set('n', '<C-w><Right>', '<C-w>l', { desc = '[→] Switch' })

vim.keymap.set('n', '<C-q>', ':q!<CR>', { desc = '[Q]uit' })
vim.keymap.set('n', '<C-w>', ':w!<CR>', { desc = '[W]rite' })
vim.keymap.set('n', '<C-e>', ':wq!<CR>', { desc = '[E] Write and Quit'})

vim.keymap.set('n', '<C-=>', '<C-w>+', { desc = '[+] Height' })
vim.keymap.set('n', '<C-->', '<C-w>-', { desc = '[-] Height' })
vim.keymap.set('n', '<C-.>', '<C-w>>', { desc = '[+] Width' })
vim.keymap.set('n', '<C-,>', '<C-w><', { desc = '[-] Width' })

vim.keymap.set({'n', 'v', 'x'}, 'Y', '"+y')
vim.keymap.set({'n', 'v', 'x'}, 'P', '"+p')

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

    vim.keymap.set('n', 'c', ':Git commit<CR>', { desc = '[C]ommit', buffer = true })
    vim.keymap.set('n', 'ce', ':Git commit --amend<CR>', { desc = '[C]ommit [E]dit', buffer = true })
    vim.keymap.set('n', 'q', '<C-w>q', { desc = '[Q]uit', buffer = true })

    local function fugitive_map(mode, keys, cmd, desc)
      vim.keymap.set(mode, keys, ':<C-U>execute <SNR>' .. vim.g.fugitive_snr .. cmd .. '<CR>',
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
  callback = function ()
    vim.keymap.set('t', '<ESC>', [[ <C-\><C-n> ]], { buffer = 0 })
  end
})

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
