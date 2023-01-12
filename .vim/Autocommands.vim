au BufNewFile,BufRead /*.rasi setf css
au BufNewFile,BufRead /*.html set filetype=html
"au BufNewFile,BufRead /*.html set filetype=htmldjango

" Auto-close pop up helpers
autocmd CompleteDone * if !pumvisible() | pclose | endif

" coc
autocmd FileType scss setl iskeyword+=@-@
au FileType css,scss let b:prettier_exec_cmd = "prettier-stylelint"

" Disable these options just when Kite is installed
" and running with vim

"autocmd FileType go let b:coc_suggest_disable = 1
"autocmd FileType python let b:coc_suggest_disable = 1
"autocmd FileType javascript let b:coc_suggest_disable = 1
command! -nargs=0 Prettier :CocCommand prettier.formatFile

