
local logo = [[
                                                                                                                                                
 ____ 
||G ||
||__||
|/__\|


]]
require('dashboard').setup {
  config = {
    header = vim.split(string.rep('\n', 2) .. logo, '\n') ,
    mru = { enable = false },
    projects = { enale = true, limit = 20 }
  }
}

vim.api.nvim_create_autocmd('BufLeave', {
  callback = function() 
    if require('nvim-tree.view').is_visible() == false then  
      require('nvim-tree.api').tree.toggle(false,true)
    end
  end
})
