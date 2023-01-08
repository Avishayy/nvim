return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "folke/neodev.nvim",
      "b0o/SchemaStore.nvim",
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      local format_augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Format through null-ls
        local function null_ls_format()
          vim.lsp.buf.format {
            -- async false so we don't need to manually save file again
            -- after format.. maybe find a solution that saves twice?
            async = false,
            bufnr = bufnr,
            filter = function(filter_client)
              return filter_client.name == "null-ls"
            end,
          }
        end

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', 'gh', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<space>f', function() null_ls_format() end, bufopts)
        vim.api.nvim_clear_autocmds({ group = format_augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = format_augroup,
          buffer = bufnr,
          callback = null_ls_format,
        })
      end

      require'lspconfig'.tsserver.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          completions = {
            completeFunctionCalls = true
          }
        },
        init_options = {
          hostInfo = "neovim",
          preferences = {
            includeCompletionsWithSnippetText = true,
            includeCompletionsForImportStatements = true,
          },
        },
      }

      require'lspconfig'.sumneko_lua.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        }
      }

      require'lspconfig'.jsonls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      }
    end
  },
  {
    "williamboman/mason.nvim",
    config = function()
     require('mason').setup {
       ui = {
         border = "rounded",
       }
     }
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim"
    },
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "tsserver",
          "pyright",
          "sumneko_lua",
          "jsonls",
        },
      }
    end
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<leader>t", "<cmd>TroubleToggle<cr>" },
    },
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    },
    config = true
  },
}
