return {
  {
    "jayp0521/mason-nvim-dap.nvim",
    dependencies = {
      "mfussenegger/nvim-dap",
      "williamboman/mason.nvim",
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "Joakker/lua-json5",
    },
    lazy = false,
    config = function()
      require("dap-python").setup("python3")

      require("mason-nvim-dap").setup {
        ensure_installed = {
          "python",
        },
      }

      -- TODO: add autocmd that loads it every time we modify it?
      require("dap.ext.vscode").load_launchjs()
    end,
  },
  {
    "mfussenegger/nvim-dap",
  },
  {
    "rcarriga/nvim-dap-ui",
    config = true,
  },
  {
    "Joakker/lua-json5",
    lazy = false,
    build = "./install.sh && cp lua/json5.{dylib,so}",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("dap.ext.vscode").json_decode = require("json5").parse
    end,
  },
}
