local map = vim.keymap.set

map("n", "<leader>l", "<cmd>Lazy<cr>")

vim.api.nvim_create_user_command("NvimRestart",
  function()
    require("utils").reload_config()
  end,
  { nargs = "*" }
)

map("", "<leader>R", "<Esc>:NvimRestart<CR>",
  { silent = true, desc = "reload nvim configuration" })

vim.g.mapleader = "\\"

-- <CR> to save
map("n", "<CR>", ":w<CR>", { desc = "Save" })

-- Quickfix list mappings
map("n", "<leader>q", "<cmd>lua require'utils'.toggle_qf('q')<CR>",
  { desc = "toggle quickfix list" })
map("n", "[q", ":cprevious<CR>", { desc = "Next quickfix" })
map("n", "]q", ":cnext<CR>", { desc = "Previous quickfix" })
map("n", "[Q", ":cfirst<CR>", { desc = "First quickfix" })
map("n", "]Q", ":clast<CR>", { desc = "Last quickfix" })
-- Location list mappings
map("n", "<leader>Q", "<cmd>lua require'utils'.toggle_qf('l')<CR>",
  { desc = "toggle location list" })
map("n", "[l", ":lprevious<CR>", { desc = "Previous location" })
map("n", "]l", ":lnext<CR>", { desc = "Next location" })
map("n", "[L", ":lfirst<CR>", { desc = "First location" })
map("n", "]L", ":llast<CR>", { desc = "Last location" })
-- Navigate tabs
map("n", "[t", ":tabprevious<CR>", { desc = "Previous tab" })
map("n", "]t", ":tabnext<CR>", { desc = "Next tab" })
map("n", "[T", ":tabfirst<CR>", { desc = "First tab" })
map("n", "]T", ":tablast<CR>", { desc = "Last tab" })
-- Navigate buffers
map("n", "[b", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "]b", ":bnext<CR>", { desc = "Next buffer" })
map("n", "[B", ":bfirst<CR>", { desc = "First buffer" })
map("n", "]B", ":blast<CR>", { desc = "Last buffer" })


-- shortcut to view :messages
map({ "n", "v" }, "<leader>m", "<cmd>messages<CR>",
  { desc = "open :messages" })
-- am I scared of clearing messages by mistake?
-- map({ "n", "v" }, "<leader>M", '<cmd>mes clear|echo "cleared :messages"<CR>',
--   { desc = "clear :messages" })

-- keep visual selection when (de)indenting
map("v", "<", "<gv", {})
map("v", ">", ">gv", {})

-- Select last pasted/yanked text
map("n", "g<C-v>", "`[v`]", { desc = "visual select last yank/paste" })

-- Do I like this?
-- Keep matches center screen when cycling with n|N
map("n", "n", "nzzzv", { desc = "Fwd  search '/' or '?'" })
map("n", "N", "Nzzzv", { desc = "Back search '/' or '?'" })

-- move along visual lines, not numbered ones
-- without interferring with {count}<down|up>
for _, m in ipairs({ "n", "v" }) do
  for _, c in ipairs({
    { "<up>", "k", "Visual line up" },
    { "<down>", "j", "Visual line down" }
  }) do
    map(m, c[1], ([[v:count == 0 ? 'g%s' : '%s']]):format(c[2], c[2]),
      { expr = true, silent = true, desc = c[3] })
  end
end

-- Search and Replace
-- 'c.' for word, 'c>' for WORD
-- 'c.' in visual mode for selection
map("n", "c.", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]],
  { desc = "search and replace word under cursor" })
map("n", "c>", [[:%s/\V<C-r><C-a>//g<Left><Left>]],
  { desc = "search and replace WORD under cursor" })
map("x", "c.",
  [[:<C-u>%s/\V<C-r>=luaeval("require'utils'.get_visual_selection(true)")<CR>//g<Left><Left>]], {})

-- Map <leader>o & <leader>O to newline without insert mode
map("n", "<leader>o",
  ':<C-u>call append(line("."), repeat([""], v:count1))<CR>',
  { silent = true, desc = "newline below (no insert-mode)" })
map("n", "<leader>O",
  ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>',
  { silent = true, desc = "newline above (no insert-mode)" })

-- Use operator pending mode to visually select entire buffer, e.g.
--    d<A-a> = delete entire buffer
--    y<A-a> = yank entire buffer
--    v<A-a> = visual select entire buffer
map("o", "<A-a>", ":<C-U>normal! mzggVG<CR>`z")
map("x", "<A-a>", ":<C-U>normal! ggVG<CR>")

-- Leave insert more with jk, kj, jj (not kk so when works end with k I can do 'breakkj' and staying with 'break')
map("i", "jk", "<ESC>")
map("i", "kj", "<ESC>")
map("i", "jj", "<ESC>")

-- WinMove shenanigans
map("n", "<C-h>", "<cmd>lua require'utils'.winmove('h')<CR>")
map("n", "<C-j>", "<cmd>lua require'utils'.winmove('j')<CR>")
map("n", "<C-k>", "<cmd>lua require'utils'.winmove('k')<CR>")
map("n", "<C-l>", "<cmd>lua require'utils'.winmove('l')<CR>")
