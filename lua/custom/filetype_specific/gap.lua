vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.g', '*.gi', '*.gd' },
  callback = function()
    vim.bo.filetype = 'gap'
  end,
})
