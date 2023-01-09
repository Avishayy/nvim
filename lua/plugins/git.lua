return {
  {
    "tpope/vim-fugitive",
    lazy = false,
    keys = {
      { "<leader>s", "<cmd>G<cr>" },
      { "<leader>gb", "<cmd>G blame -w<cr>" },
    },
    cmd = "G",
  },
  {
    "sindrets/diffview.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    keys = {
      { "<leader>d", ":DiffviewOpen " },
      { "<leader>D", "<cmd>DiffviewClose<cr>" },
    },
    cmd = "DiffviewOpen",
  },
}
