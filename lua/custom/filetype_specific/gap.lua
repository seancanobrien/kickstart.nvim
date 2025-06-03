vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.g' },
  callback = function()
    vim.bo.filetype = 'gap'
  end,
})
