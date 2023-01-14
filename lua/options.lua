local o = vim.opt

-- General opts
o.cmdheight = 1
o.completeopt = "menuone,noselect"
o.confirm = true
o.cursorline = false
o.equalalways = false
o.fileformats = "unix,dos"
o.hidden = false
o.laststatus = 3
o.mouse = "a"
o.showmode = false
o.splitbelow = false
o.splitright = true
o.termguicolors = true
o.timeoutlen = 250
o.undofile = true
o.swapfile = false
o.backup = false
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

-- Prefer ripgrep to grep.
if (1 == vim.fn.executable("rg")) then
    o.grepprg="rg --vimgrep"
    o.grepformat:prepend{"%f:%l:%c:%m"}
end

-- Disable some in built plugins completely
local disabled_built_ins = {
  -- Needed for vim-rhubarb 
  -- "netrw",
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

-- Don't jump sign column on errors
o.signcolumn="yes:1"

-- Diagnostics
-- For CursorHold of diagnostic
o.updatetime = 250
vim.diagnostic.config({
  virtual_text = false,
})
local function lspSymbol(name, icon)
  local hl = "DiagnosticSign" .. name;
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
lspSymbol("Error", "")
lspSymbol("Hint", "")
lspSymbol("Info", "")
lspSymbol("Warning", "")
