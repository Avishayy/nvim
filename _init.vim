call plug#begin()

" fzf {{{
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    function! s:build_quickfix_list(lines)
      call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
      copen
      cc
    endfunction

    let g:fzf_action = {
      \ 'ctrl-q': function('s:build_quickfix_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }

    command! -bang -nargs=* Rg call fzf#vim#grep("rg --no-ignore --hidden --glob '!.git' --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)
 
    let g:fzf_files_options = '--preview "(cat {}) 2> /dev/null "'
    nmap <C-P> :Files<CR>
" }}}

" Allows to quickly manipulate surrounding objects
Plug 'tpope/vim-surround'

" Bracket nappings
Plug 'tpope/vim-unimpaired'

" Legendary git wrapper
Plug 'tpope/vim-fugitive'
Plug 'sodapopcan/vim-twiggy'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-rhubarb'

nnoremap <leader>t :Twiggy<CR>

nnoremap <leader>gs :Git<CR>
nnoremap <leader>gb :Git blame<CR>

" Quickly comment / uncomment shenenigans
Plug 'tpope/vim-commentary'

" ABOLISHMENT
Plug 'tpope/vim-abolish'

" Repeat tpope stuff
Plug 'tpope/vim-repeat'

" Snippets manager

" Don't overwrite my Coc expansion..
" let g:UltiSnipsExpandTrigger       =  "<nop>"
" let g:UltiSnipsListSnippets        =  "<nop>"
" let g:UltiSnipsJumpForwardTrigger  =  "<nop>"
" let g:UltiSnipsJumpBackwardTrigger =  '<nop>'
Plug 'SirVer/ultisnips'

Plug 'chriskempson/base16-vim'

" Semantic highlighting
Plug 'jackguo380/vim-lsp-cxx-highlight'

" Statusline
let g:lightline = { 
	\ 'active': {
	\     'left': [ [ 'mode', 'paste' ],
	\             [ 'readonly', 'filename', 'modified' ] ],
    \     'right': [ [ 'lineinfo' ],
    \                [ 'percent' ],
    \                [ 'current_function', 'zoom', 'fileformat', 'fileencoding', 'filetype' ] ]
	\ },
    \ 'component_function': {
    \     'filename': 'LightlineFilename',
    \     'current_function': 'TreeSitterStatusLine',
    \     'zoom': 'zoom#statusline'
    \ },
    \ 'colorscheme': 'base16'
\ }

" I want quickfix / locationlist windows to use their name rather than "Location List"
function! LightlineFilename()
    if &buftype ==# 'quickfix'
        return get(w:, 'quickfix_title', '')
    endif
    
    let filename = expand('%:.')
    return !empty(filename) ? filename : "[No Name]"
endfunction

" I don't want the last colon in the statusline, it's distracting
function! TreeSitterStatusLine()
   let treesitter_statusline = nvim_treesitter#statusline()
   if type(treesitter_statusline) == v:t_string
     return treesitter_statusline[:-2] 
   endif
endfunction

Plug 'itchyny/lightline.vim'
Plug 'avishayy/vim-base16-lightline'

" lightline already shows the current mode
set noshowmode

Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

nmap <leader>T :NERDTreeToggle<CR>

" jsx stuff
Plug 'maxmellon/vim-jsx-pretty'

" Startify
Plug 'mhinz/vim-startify'
let g:startify_change_to_dir = 0

" Dockerfiel syntax highlighting
" Plug 'ekalinin/Dockerfile.vim'

" Zoom windows
Plug 'dhruvasagar/vim-zoom'
 
nmap <leader>z <Plug>(zoom-toggle)

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

Plug 'tpope/vim-eunuch'

Plug 'avishayy/hi-words.vim'

Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python'

Plug 'lepture/vim-jinja'

set termguicolors
Plug 'norcalli/nvim-colorizer.lua'

Plug 'nvim-lua/plenary.nvim'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'tpope/vim-obsession'

Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For ultisnips users.
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'folke/trouble.nvim'

Plug 'lvimuser/lsp-inlayhints.nvim'

" }
"
"

call plug#end()


lua << EOF
  vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
  vim.api.nvim_create_autocmd("LspAttach", {
    group = "LspAttach_inlayhints",
    callback = function(args)
      if not (args.data and args.data.client_id) then
        return
      end

      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      require("lsp-inlayhints").on_attach(client, bufnr)
    end,
  })

  require("trouble").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

" LSP setup
lua require'lspconfig'.pyright.setup{}
lua << EOF
require'lspconfig'.tsserver.setup({
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    }
  }
})

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gh', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
}
local vint = require "efm/vint"
local stylua = require "efm/stylua"
local luacheck = require "efm/luacheck"
local staticcheck = require "efm/staticcheck"
local go_vet = require "efm/go_vet"
local goimports = require "efm/goimports"
local black = require "efm/black"
local isort = require "efm/isort"
local flake8 = require "efm/flake8"
local mypy = require "efm/mypy"
local prettier = require "efm/prettier"
local eslint = require "efm/eslint"
local shellcheck = require "efm/shellcheck"
local shfmt = require "efm/shfmt"
local terraform = require "efm/terraform"
local misspell = require "efm/misspell"
local opa = require "efm/opa"
-- https://github.com/mattn/efm-langserver
require('lspconfig')['efm'].setup {
    capabilities = capabilities,
    cmd = { "efm-langserver" },
    on_attach = on_attach,
    init_options = { documentFormatting = true },
    root_dir = vim.loop.cwd,
    settings = {
        rootMarkers = { ".git/" },
        lintDebounce = 100,
        -- logLevel = 5,
        languages = {
            ["="] = { misspell },
            vim = { vint },
            lua = { stylua, luacheck },
            go = { staticcheck, goimports, go_vet },
            python = { black, isort, flake8, mypy },
            typescript = { prettier },
            javascript = { prettier },
            typescriptreact = { prettier },
            javascriptreact = { prettier },
            yaml = { prettier },
            json = { prettier },
            html = { prettier },
            scss = { prettier },
            css = { prettier },
            markdown = { prettier },
            sh = { shellcheck, shfmt },
            terraform = { terraform },
            rego = { opa },
        },
    },
}

vim.api.nvim_create_autocmd("BufWritePre", { callback = function() vim.lsp.buf.formatting_seq_sync() end })
vim.api.nvim_create_autocmd("CursorHold", {
  buffer = bufnr,
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end
})

EOF

set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<TAB>'] = cmp.mapping.select_next_item(),
      ['<S-TAB>'] = cmp.mapping.select_prev_item(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['tsserver'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }
EOF

lua require'colorizer'.setup()

lua require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
lua require('dap-python').test_runner = 'pytest'

nnoremap <silent> <leader>dn :lua require('dap-python').test_method()<CR>
nnoremap <silent> <leader>df :lua require('dap-python').test_class()<CR>
vnoremap <silent> <leader>ds <ESC>:lua require('dap-python').debug_selection()<CR>

lua <<EOF
local M = {}
M.attach_python_debugger = function(args)
    local dap = require "dap"
    local host = args[1] -- This should be configured for remote debugging if your SSH tunnel is setup.
    -- You can even make nvim responsible for starting the debugpy server/adapter:
    --  vim.fn.system({"${some_script_that_starts_debugpy_in_your_container}", ${script_args}})
    pythonAttachAdapter = {
        type = "server";
        host = host;
        port = tonumber(5678);
    }
    pythonAttachConfig = {
        type = "python";
        request = "attach";
        connect = {
            port = tonumber(5678);
            host = host;
        };
        mode = "remote";
        name = "Remote Attached Debugger";
        cwd = vim.fn.getcwd();
        pathMappings = {
            {
                localRoot = vim.fn.getcwd(); -- Wherever your Python code lives locally.
                remoteRoot = "/usr/src/app"; -- Wherever your Python code lives in the container.
            };
        };
    }
    local session = dap.attach(host, tonumber(5678), pythonAttachConfig)
    if session == nil then
        io.write("Error launching adapter");
    end
    dap.repl.open()
end
EOF

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all"  or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

lua <<EOF
require'nvim-treesitter.configs'.setup {
  indent = {
    enable = true
  }
}
EOF

" must be placed after plug#end
colorscheme base16-default-dark

" Bindings {{{

" Exit from insert mode easily
inoremap jk <ESC>
inoremap kj <ESC>

nnoremap <silent> <C-h> :call winmove#WinMove('h')<CR>
nnoremap <silent> <C-j> :call winmove#WinMove('j')<CR>
nnoremap <silent> <C-k> :call winmove#WinMove('k')<CR>
nnoremap <silent> <C-l> :call winmove#WinMove('l')<CR>

" Enter to save only on stuff that should be saved..
" Maybe use update instead?
function! MapCR()
    if empty(&buftype)
        return ":w\<CR>"
    elseif get(w:, 'quickfix_title', '') ==# 'Man TOC'
        return "\<CR>:lclo\<CR>"
    endif
    return "\<CR>"
endfunction
nnoremap <expr> <CR> MapCR()

nnoremap <C-F> :Rg <C-R><C-W><CR>

" }}}

function! FDB(new_name, is_style)
    norm ld%
    if a:is_style
        norm istyles.jkl
    endif
    exe "norm i" . a:new_name . "jk"
    if a:is_style
        exe "norm G?styles =\<CR>%O: ,jkP^"
        exe "norm i" . a:new_name . "jk"
    else
        exe "norm Go\<CR>const " . a:new_name . ": any = jkp"
    endif
    exe "norm ^f{a\<CR>\<Tab>jkf}i\<CR>"
endfunction
    

" Leader bindings {{{

let mapleader = "\\"

nnoremap <leader>s :source $MYVIMRC<CR>
nnoremap <leader>e :e $MYVIMRC<CR>

" Scroll the viewport faster
nnoremap <C-e> 3<C-e>3j
nnoremap <C-y> 3<C-y>3k

" Go to the last file with double space
nnoremap <space><space> :b#<CR>

" }}}

" Options {{{

" Don't automatically insert comment leader when pressing o / O
set formatoptions-=o

" Side numbers
set number
set relativenumber

" I like them in groups of 4
setg tabstop=4
setg shiftwidth=4
setg softtabstop=4
setg expandtab

augroup ft_group
    autocmd!
    autocmd Filetype javascript,html,typescript,typescriptreact,java setlocal ts=2 sw=2 sts=2
augroup end

" Macros {{{
" }}}
