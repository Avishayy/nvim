nnoremap <buffer> gp :Git push<CR>
nnoremap <buffer> gP :Git push -f
nnoremap <buffer> gu :Git branch -u origin/main<CR>
nnoremap <buffer> gU :execute "Git branch -u origin/".g:FugitiveHead()<CR>
