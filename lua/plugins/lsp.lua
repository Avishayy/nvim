return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      local on_attach = function(client, bufnr)
        -- If the LSP supports formatting, allow for format-on-save through LSP
        if client.server_capabilities.document_formatting then
          vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
        end
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
    end
  },
  {
    "williamboman/mason.nvim",
    config = true,
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
        },
      }
    end
  },
}
