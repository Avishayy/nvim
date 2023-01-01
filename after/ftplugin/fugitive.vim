nnoremap <buffer> gp :Git push<CR>
nnoremap <buffer> gP :Git push -f
nnoremap <buffer> gl :Git pull<CR>
nnoremap <buffer> gu :Git branch -u origin/main<CR>
nnoremap <buffer> gU :execute "Git branch -u origin/".g:FugitiveHead()<CR>
nnoremap <buffer> c- :Git checkout -<CR>
nnoremap <buffer> cm :Git checkout main<CR>
nnoremap <buffer> grom :Git rebase -i origin/main<CR>
