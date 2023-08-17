return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "folke/neodev.nvim",
      "b0o/SchemaStore.nvim",
      "lvimuser/lsp-inlayhints.nvim",
      "simrat39/rust-tools.nvim",
      "gfanto/fzf-lsp.nvim",
      "jose-elias-alvarez/typescript.nvim",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Enable inlay hints
        require("lsp-inlayhints").on_attach(client, bufnr)

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        local nsilent_bufopts = { noremap = true, buffer = bufnr }

        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "gh", vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set("n", "<space>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set("n", "<space>s", ":WorkspaceSymbols ", nsilent_bufopts)
        vim.keymap.set("n", "<space>d", "<cmd>DocumentSymbols<CR>", bufopts)
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
        -- Uses IncRename instead
        -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

        if client.server_capabilities.semanticTokensProvider then
          vim.lsp.semantic_tokens.start(bufnr, client.id)
          vim.cmd([[ highlight link @interface @type ]])
        end
      end

      require("typescript").setup {
        server = {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = {
            completions = {
              completeFunctionCalls = true,
            },
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
          init_options = {
            hostInfo = "neovim",
            preferences = {
              includeCompletionsWithSnippetText = true,
              includeCompletionsForImportStatements = true,
            },
          },
        },
      }

      require("neodev").setup {
        -- add any options here, or leave empty to use the default settings
      }

      require("lspconfig").lua_ls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            completion = {
              callSnippet = "Replace",
            },
            telemetry = {
              enable = false,
            },
          },
        },
      }

      require("lspconfig").jsonls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      }

      require("lspconfig").pyright.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        before_init = function(params, config)
          local Path = require("plenary.path")
          local venv = Path:new((config.root_dir:gsub("/", Path.path.sep)), ".venv")
          if venv:joinpath("bin"):is_dir() then
            config.settings.python.pythonPath = tostring(venv:joinpath("bin", "python"))
          end
        end,
      }

      require("lspconfig").clangd.setup {
        capabilities = capabilities,
        on_attach = on_attach,
      }

      require("rust-tools").setup {
        server = {
          on_attach = on_attach,
        },
      }

      require("lspconfig").kotlin_language_server.setup {
        server = {
          capabilities = capabilities,
          on_attach = on_attach,
        },
      }
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup {
        ui = {
          border = "rounded",
        },
      }
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "BufReadPost",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "tsserver",
          "pyright",
          "lua_ls",
          "jsonls",
          "rust_analyzer",
          "kotlin_language_server",
        },
      }
    end,
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
    config = true,
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    config = function()
      require("lsp-inlayhints").setup {
        inlay_hints = {
          only_current_line = true,
        },
      }
    end,
  },
  {
    "gfanto/fzf-lsp.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "junegunn/fzf",
    },
  },
  {
    "smjonas/inc-rename.nvim",
    cmd = {
      "IncRename",
    },
    keys = {
      { "<space>rn", ":IncRename " },
    },
    config = true,
  },
}
