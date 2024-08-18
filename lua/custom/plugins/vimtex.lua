return {
  -- VimTeX
  {
    'lervag/vimtex',
    lazy = false, -- we don't want to lazy load VimTeX
    init = function()
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_compiler_latexmk = {
        -- Directory for output pdf and auxilary files
        out_dir = 'build',
      }
    end,
  },
}
