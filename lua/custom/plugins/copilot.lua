-- Copilot completion.
return {
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    opts = {
      -- The panel is useless.
      panel = { enabled = false },
      suggestion = {
        auto_trigger = false,
        hide_during_completion = false,
        keymap = {
          accept = '<C-.>',
          accept_word = '<M-w>',
          accept_line = '<M-l>',
          next = '<C-j>',
          prev = '<C-k>',
          dismiss = '<C-/>',
        },
      },
      filetypes = {
        markdown = true,
        yaml = true,
      },
    },
  },
}
