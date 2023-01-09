return {
  {
    "tpope/vim-fugitive",
    dependencies = {
      "tpope/vim-rhubarb",
    },
    keys = {
      { "<leader>s", "<cmd>G<cr>" },
      { "<leader>gb", "<cmd>G blame -w<cr>" },
      { "<leader>gB", "<cmd>GBrowse<cr>" },
      { "<leader>gB", ":'<'>GBrowse<cr>", mode = { "v" } },
    },
    cmd = { "G", "Git", "GBrowse" },
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
