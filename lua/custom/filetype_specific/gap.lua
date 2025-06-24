vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.g' },
  callback = function()
    vim.bo.filetype = 'gap'
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'gap',
  callback = function()
    vim.bo.commentstring = '# %s'
  end,
})
