" Plygot
" if identation fails
"let g:polyglot_disabled = ['autoindent']
" if languages identification fails
"let g:polyglot_disabled = ['sensible']
" Disable autocommands
"let g:polyglot_disabled = ['ftdetect']

" indentline
let g:indentLine_bufNameExclude = ['NERD_tree.*', 'term:.*']
let g:indentLine_fileTypeExclude = ['text', 'sh', 'help', 'terminal']

" Shfmt
let g:shfmt_fmt_on_save = 1

if executable('shfmt')
  let &l:formatprg='shfmt -i ' . &l:shiftwidth . ' -ln posix -sr -ci -s'
endif
