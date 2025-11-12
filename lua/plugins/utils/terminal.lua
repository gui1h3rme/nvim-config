local options = {
  size = 10,
  open_mapping = [[<C-/>]],
  start_in_insert = true,
  direction = 'horizontal'
}

if vim.fn.has('win32') == 1 then
  options.shell = 'powershell.exe'
end

return {
  'akinsho/toggleterm.nvim',
  opts = options
}
