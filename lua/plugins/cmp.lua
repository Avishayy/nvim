return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "onsails/lspkind.nvim",
  },

  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    local has_words_before = function()
      if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
        return false
      end
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
    end

    cmp.setup {
      snippet = {
        -- must use a snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      window = {
        completion = { border = "single" },
        documentation = { border = "single" },
      },

      completion = {
        -- start completion immediately
        keyword_length = 1,
      },

      sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "path" },
        {
          name = "buffer",
          option = {
            keyword_pattern = [[\k\+]],
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end,
          },
        },
      },

      -- we use 'comleteopt=...,noselect' but we still want cmp to autoselect
      -- an item if recommended by the LSP server (try with gopls, rust_analyzer)
      -- uncomment to disable
      -- preselect = cmp.PreselectMode.None,

      mapping = {
        ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i" }),
        ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i" }),
        ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        ["<S-up>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<S-down>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i" }),
        ["<C-e>"] = cmp.mapping {
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        },
        ["<C-y>"] = cmp.mapping.confirm { select = true, behavior = cmp.ConfirmBehavior.Replace },
        -- ['<CR>'] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Insert })
        -- close the cmp interface if no item is selected, I find it more
        -- intuitive when using LSP autoselect (instead of sending <CR>)
        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if cmp.get_selected_entry() then
              cmp.confirm { select = false, cmp.ConfirmBehavior.Insert }
            else
              cmp.close()
            end
          else
            fallback()
          end
        end),
      },

      formatting = {
        format = lspkind.cmp_format {
          mode = "symbol", -- show only symbol annotations
          maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

          -- The function below will be called before any actual modifications from lspkind
          -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
          -- before = function (entry, vim_item)
          --   ...
          --   return vim_item
          -- end
        },
      },

      -- DO NOT ENABLE
      -- just for testing with nvim native completion menu
      experimental = {
        native_menu = false,
        ghost_text = true,
      },
    }

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline("/", {
      sources = {
        { name = "buffer" },
      },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
  end,
}
