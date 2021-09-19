call plug#begin()

" coc stuff {{{
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " TextEdit might fail if hidden is not set.
    set hidden

    " Some servers have issues with backup files, see #649.
    set nobackup
    set nowritebackup

    " Give more space for displaying messages.
    set cmdheight=2

    " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    " delays and poor user experience.
    set updatetime=300

    " Don't pass messages to |ins-completion-menu|.
    set shortmess+=c

    " Always show the signcolumn, otherwise it would shift the text each time
    " diagnostics appear/become resolved.
    set signcolumn=yes

    " Use tab to trigger completion after non whitespace character and navigation.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
      endfunction

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
    " position. Coc only does snippet and additional edit on confirm.
    " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

    " Use `[g` and `]g` to navigate diagnostics
    " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window.
    " This doesn't break normal K usage :)
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Symbol renaming.
    nmap <F2> <Plug>(coc-rename)

    " Formatting selected code.
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder.
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap keys for applying codeAction to the current buffer.
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Map function and class text objects
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)

    " Use CTRL-S for selections ranges.
    " Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
    nmap <silent> <C-s> <Plug>(coc-range-select)
    xmap <silent> <C-s> <Plug>(coc-range-select)

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')

    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Add (Neo)Vim's native statusline support.
    " NOTE: Please see `:h coc-status` for integrations with external plugins that
    " provide custom statusline: lightline.vim, vim-airline.
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


    function! CocGetCurrentFunction()
        return get(b:,'coc_current_function','')
    endfunction

    " Mappings for CoCList
    " Show all diagnostics.
    nnoremap <silent><nowait> <space>d  :<C-u>CocList diagnostics<cr>
    " Manage extensions.
    nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
    " Show commands.
    nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document.
    nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols.
    nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list.
    nnoremap <silent><nowait> <space>l  :<C-u>CocListResume<CR>


    let g:coc_global_extensions = [ 'coc-clangd', 'coc-rust-analyzer', 'coc-tsserver', 'coc-pyright' ]
" }}}

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
let g:UltiSnipsExpandTrigger       =  "<nop>"
let g:UltiSnipsListSnippets        =  "<nop>"
let g:UltiSnipsJumpForwardTrigger  =  "<nop>"
let g:UltiSnipsJumpBackwardTrigger =  '<nop>'
Plug 'SirVer/ultisnips'

set background=dark
let base16colorspace=256
Plug 'chriskempson/base16-vim'

" Semantic highlighting
Plug 'jackguo380/vim-lsp-cxx-highlight'

" Statusline
let g:lightline = { 
	\ 'active': {
	\     'left': [ [ 'mode', 'paste' ],
	\             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ],
    \     'right': [ [ 'lineinfo' ],
    \                [ 'percent' ],
    \                [ 'current_function', 'zoom', 'fileformat', 'fileencoding', 'filetype' ] ]
	\ },
    \ 'component_function': {
    \     'filename': 'LightlineFilename',
    \     'cocstauts': 'coc#status',
    \     'current_function': 'nvim_treesitter#statusline',
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
Plug 'ekalinin/Dockerfile.vim'

" Zoom windows
Plug 'dhruvasagar/vim-zoom'
 
nmap <leader>z <Plug>(zoom-toggle)

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

" }

call plug#end()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
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
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

autocmd Filetype html,typescript,typescriptreact setlocal ts=2 sw=2 sts=2

" Search is case insensitive, can be overriden with \c or \C
set ignorecase

" Always show 3 lines of context above and below current line
set scrolloff=3

" Persistent undo
set undofile

" Mouse is till nice
set mouse=a

" Show live substitution
set inccommand=nosplit

" }}}

" Command line abbreviations {{{
cnoreabbrev man Man
cnoreabbrev vimdir ~/.config/nvim/
cnoreabbrev So so
" }}}
