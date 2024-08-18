-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
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

  -- Snippets
  {
    'SirVer/ultisnips',
    config = function()
      vim.g.UltiSnipsExpandTrigger = '<tab>'
      vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
      vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
    end,
  },

  -- Session manager
  {
    'rmagatti/auto-session',
    dependencies = {
      'nvim-telescope/telescope.nvim', -- Only needed if you want to use sesssion lens
    },
    config = function()
      require('auto-session').setup {
        auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      }
    end,
  },

  --floating terminal
  {
    'voldikss/vim-floaterm',
    config = function()
      -- vim.api.nvim_set_keymap('n', '<leader>bb', '<cmd>FloatermToggle --width=0.9 --height=0.9<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>bb', '<cmd>FloatermNew --width=0.9 --height=0.9<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>bk', '<cmd>FloatermKill<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>bn', '<cmd>FloatermNext<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>bp', '<cmd>FloatermPrev<CR>', { noremap = true, silent = true })
    end,
  },

  -- Adds custom dictionary and ignore functionality to ltex
  { 'barreiroleo/ltex-extra.nvim' },

  -- Undotree
  {
    'mbbill/undotree',
    config = function()
      vim.g.undotree_WindowLayout = 2
      vim.api.nvim_set_keymap('n', '<leader>uu', ':UndotreeToggle<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>uf', ':UndotreeFocus<CR>', { noremap = true, silent = true })
    end,
  },

  -- Git diffs
  { 'sindrets/diffview.nvim' },

  --Rainbow delimiters
  {
    'HiPhish/rainbow-delimiters.nvim',
    config = function()
      local rainbow_delimiters = require 'rainbow-delimiters'

      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        priority = {
          [''] = 110,
          lua = 210,
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end,
  },

  -- Multi cursors
  { 'mg979/vim-visual-multi' },

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

  -- Handy shortcuts
  { 'tpope/vim-unimpaired' },

  -- Plugin for GhostText.
  -- For writing text in to a browser using vim <3
  { 'subnut/nvim-ghost.nvim' },

  -- File navigation
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup {}

      vim.keymap.set('n', '<leader>al', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Harpoon Quick Menu' })

      vim.keymap.set('n', '<leader>aa', function()
        harpoon:list():add()
      end, { desc = 'Add File to Harpoon' })

      vim.keymap.set('n', '<C-T>1', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<C-T>2', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<C-T>3', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<C-T>4', function()
        harpoon:list():select(4)
      end)
      vim.keymap.set('n', '<C-T>5', function()
        harpoon:list():select(5)
      end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<C-S-P>', function()
        harpoon:list():prev()
      end)
      vim.keymap.set('n', '<C-S-N>', function()
        harpoon:list():next()
      end)
    end,
  },

  -- Little lines wherever indenting is happening
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },

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
