return {
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true },
      -- 'williamboman/mason-lspconfig.nvim',
      -- 'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      -- Set up capabilities with completion support
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Global LSP configuration using vim.lsp.config()
      vim.lsp.config('*', {
        -- capabilities = capabilities,
        -- This function runs when any LSP attaches to a buffer
        on_attach = function(client, bufnr)
          -- Create a function for easy keymap creation
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
          end

          -- LSP keymaps
          map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
          map('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
          map('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
          map('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
          map('<leader>~b', vim.lsp.buf.document_symbol, '[~]ymbols in [B]uffer')
          map('<leader>~w', vim.lsp.buf.workspace_symbol, '[~]ymbols in [W]orkspace')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Document highlighting
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight-' .. bufnr, { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = bufnr,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = bufnr,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
          end

          -- Inlay hints
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
            end, '[T]oggle Inlay [H]ints')
            -- Start with inlays disabled
            vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
          end

          -- Disable virtual text diagnostics
          vim.diagnostic.config({
            virtual_text = false,
          }, vim.api.nvim_get_current_buf())
        end,
      })

      -- Configure specific language servers using vim.lsp.config()

      -- Lua Language Server
      vim.lsp.config('lua_ls', {
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml' },
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                -- Add other library paths if needed
              },
            },
            completion = {
              callSnippet = 'Replace',
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      -- LTeX (LaTeX/Markdown grammar checking)
      vim.lsp.config('ltex', {
        cmd = { 'ltex-ls' },
        filetypes = { 'tex', 'latex', 'markdown' },
        settings = {
          ltex = {
            language = 'en-GB',
          },
        },

        on_attach = function(client, bufnr)
          -- Delay attach until the buffer is fully initialized
          vim.schedule(function()
            if not vim.api.nvim_buf_is_valid(bufnr) then
              return
            end

            -- Call the global on_attach first
            local global_on_attach = vim.lsp.config['*'] and vim.lsp.config['*'].on_attach
            if global_on_attach then
              pcall(global_on_attach, client, bufnr)
            end

            -- Then add ltex-specific setup
            local ok, ltex_extra = pcall(require, 'ltex_extra')
            if ok then
              ltex_extra.setup {
                load_langs = { 'en-GB' },
                init_check = true,
                path = '.dictionaries',
              }
            end
          end)
        end,
        -- on_attach = function(client, bufnr)
        --   -- Call the global on_attach first
        --   vim.lsp.config['*'].on_attach(client, bufnr)
        --
        --   -- Then add ltex-specific setup
        --   require('ltex_extra').setup {
        --     load_langs = { 'en-GB' },
        --     init_check = true,
        --     path = '.dictionaries',
        --   }
        -- end,
      })

      vim.lsp.enable 'ltex'

      -- Setup Mason for automatic installation
      require('mason').setup()
      --
      -- local ensure_installed = {
      --   'lua-language-server',
      --   'ltex-ls',
      --   'stylua', -- Lua formatter
      -- }
      --
      -- require('mason-tool-installer').setup {
      --   ensure_installed = ensure_installed,
      -- }

      -- Optional: You can still use mason-lspconfig for automatic setup of servers
      -- that you don't want to configure manually with vim.lsp.config()
      -- require('mason-lspconfig').setup {
      --   handlers = {
      --     function(server_name)
      --       -- Only setup servers that aren't already configured with vim.lsp.config()
      --       local configured_servers = { 'lua_ls', 'ltex' }
      --       if not vim.tbl_contains(configured_servers, server_name) then
      --         require('lspconfig')[server_name].setup {
      --           capabilities = capabilities,
      --         }
      --       end
      --     end,
      --   },
      -- }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
