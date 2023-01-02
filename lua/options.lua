local o = vim.opt

-- General opts
o.cmdheight = 1
o.completeopt = "menuone,noselect"
o.confirm = true
o.cursorline = false
o.equalalways = false
o.fileformats = "unix"
o.hidden = false
o.laststatus = 3
o.mouse = "a"
o.showmode = false
o.splitbelow = true
o.splitright = true
o.termguicolors = true
o.timeoutlen = 250
o.undofile = true
o.wrap = false
o.formatoptions = o.formatoptions - 'o'

-- Side numbers
o.number = true
o.relativenumber = true

-- Search
o.ignorecase = true
o.scrolloff = 3

-- Tabs
o.breakindent = true
o.copyindent = true
o.expandtab = true
o.shiftwidth = 4
o.softtabstop = 4
o.tabstop = 4

-- Swap directory
vim.g.swap_dir = vim.fn.stdpath("data") .. "/swap"
vim.fn.mkdir(vim.g.swap_dir, "p")
vim.o.directory = vim.g.swap_dir .. ',.'

-- Prefer ripgrep to grep.
if (1 == vim.fn.executable("rg")) then
    o.grepprg="rg --vimgrep"
    o.grepformat:prepend{"%f:%l:%c:%m"}
end

-- Disable some in built plugins completely
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end
