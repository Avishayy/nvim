return {
  {
    "junegunn/fzf",
    build = ":call fzf#install()"
  },
  {
    "junegunn/fzf.vim",
    dependencies = {
      "junegunn/fzf",
    },
    keys = {
      { "<C-p>", "<cmd>Files<cr>" },
      -- <Cmd> mappings interpret keycodes (<c-r><c-w>) as plain, so we need
      -- a regular mapping here
      { "<C-f>", ":Rg <c-r><c-w><cr>" },
    },
    cmd = {
      "Rg",
      "GFiles",
      "Buffers",
      "Marks",
      "History",
      "Commits",
      "BCommits",
      "Commands",
      "Maps",
      "Filetypes",
    }
  },
}
