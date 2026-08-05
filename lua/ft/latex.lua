-- TeX comments with `%`. Neovim's ftplugin already sets this for `tex`, but not
-- for `bib`, so set it explicitly across the family.
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'tex', 'plaintex', 'latex', 'context', 'bib' },
  callback = function()
    vim.bo.commentstring = '% %s'
  end,
})

-- Automatically runs a linter that puts sentences on new lines each write
-- vim.api.nvim_create_autocmd('BufWritePost', {
--   pattern = '*.tex',
--   command = 'silent! !bash /home/sean/.scripts/nvim/lint_latex_sentences.sh %',
-- })
