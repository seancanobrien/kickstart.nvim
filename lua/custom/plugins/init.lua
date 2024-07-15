-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- VimTeX
  {
    'lervag/vimtex',
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_compiler_latexrun = {
        build_dir = 'build',
      }
    end,
  },

  -- a different undo tree
  {
    'mbbill/undotree',
    config = function()
      vim.g.undotree_WindowLayout = 2
      vim.api.nvim_set_keymap('n', '<leader>uu', ':UndotreeToggle<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>uf', ':UndotreeFocus<CR>', { noremap = true, silent = true })
    end,
  },

  -- Undo tree
  -- {
  --   'jiaoshijie/undotree',
  --   dependencies = 'nvim-lua/plenary.nvim',
  --   config = function()
  --     require('undotree').setup()
  --   end,
  --   keys = { -- load the plugin only when using it's keybinding:
  --     { '<leader>u', "<cmd>lua require('undotree').toggle()<cr>" },
  --   },
  -- },

  -- different ltex plugin
  { 'barreiroleo/ltex-extra.nvim' },

  -- Better LSP diagnostics
  -- {
  --   'dgagn/diagflow.nvim',
  --   -- event = 'LspAttach', This is what I use personnally and it works great
  --   opts = {},
  -- },

  -- Search undo tree using telescope
  {
    'debugloop/telescope-undo.nvim',
    dependencies = { -- note how they're inverted to above example
      {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
      },
    },
    keys = {
      { -- lazy style key map
        '<leader>su',
        '<cmd>Telescope undo<cr>',
        desc = '[S]earch [U]ndo history',
      },
    },
    opts = {
      -- don't use `defaults = { }` here, do this in the main telescope spec
      extensions = {
        undo = {
          -- telescope-undo.nvim config, see below
        },
        -- no other extensions here, they can have their own spec too
      },
    },
    config = function(_, opts)
      -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
      -- configs for us. We won't use data, as everything is in it's own namespace (telescope
      -- defaults, as well as each extension).
      require('telescope').setup(opts)
      require('telescope').load_extension 'undo'
    end,
  },

  -- Zen mode
  {
    'folke/zen-mode.nvim',
    opts = {
      window = {
        backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = 110, -- width of the Zen window
        height = 0.95, -- height of the Zen window
        -- by default, no options are changed for the Zen window
        -- uncomment any of the options below, or add other vim.wo options you want to apply
        options = {
          -- signcolumn = "no", -- disable signcolumn
          -- number = false, -- disable number column
          -- relativenumber = false, -- disable relative numbers
          -- cursorline = false, -- disable cursorline
          -- cursorcolumn = false, -- disable cursor column
          -- foldcolumn = "0", -- disable fold column
          -- list = false, -- disable whitespace characters
        },
      },
      plugins = {
        -- disable some global vim options (vim.o...)
        -- comment the lines to not apply the options
        options = {
          enabled = true,
          ruler = false, -- disables the ruler text in the cmd line area
          showcmd = false, -- disables the command in the last line of the screen
          -- you may turn on/off statusline in zen mode by setting 'laststatus'
          -- statusline will be shown only if 'laststatus' == 3
          laststatus = 0, -- turn off the statusline in zen mode
        },
        twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
        gitsigns = { enabled = false }, -- disables git signs
        tmux = { enabled = true }, -- disables the tmux statusline
        todo = { enabled = false }, -- if set to "true", todo-comments.nvim highlights will be disabled
        -- this will change the font size on kitty when in zen mode
        -- to make this work, you need to set the following kitty options:
        -- - allow_remote_control socket-only
        -- - listen_on unix:/tmp/kitty
        kitty = {
          enabled = false,
          -- font = '+0', -- font size increment
        },
      },
    },

    -- If using opts AND config, you need to do as below, passing opts to the necessary setup function
    config = function(_, opts)
      vim.keymap.set('n', '<leader>z', '<cmd>ZenMode<CR>')
      require('zen-mode').setup(opts)
    end,
  },
}
