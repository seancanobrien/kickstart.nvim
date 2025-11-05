return {
  -- VimTeX
  {
    'lervag/vimtex',
    lazy = false, -- we don't want to lazy load VimTeX
    init = function()
      -- makes the quickfix window go away after any keystrokes
      vim.g.vimtex_quickfix_autoclose_after_keystrokes = 1
      -- Skim is MacOS pdf viewer alternative to zathura
      vim.g.vimtex_view_method = 'skim'
      vim.g.vimtex_compiler_latexmk = {
        -- Directory for output pdf and auxilary files
        out_dir = 'build',
      }
      -- auto indent every save
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*.tex',
        callback = function()
          local view = vim.fn.winsaveview()
          vim.cmd 'keepjumps normal! gg=G'
          vim.fn.winrestview(view)
        end,
      })
    end,
  },
}
