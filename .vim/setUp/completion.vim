" coc
autocmd FileType json syntax match Comment +\/\/.\+$+
"" Prettier, Emmet, HTML, CSS/Less/Sass, Json, JS/TS, Vue, Bash, Rust, Ruby, R, C/C++, PHP, Cmake, Go
" Rust
let g:coc_global_extensions = [
  \'coc-prettier',
  \'coc-emmet',
  \'coc-html',
  \'coc-css',
  \'coc-json',
  \'coc-tsserver',
  \'coc-vetur',
  \'coc-sh',
  \'coc-rls',
  \'coc-solargraph',
  \'coc-r-lsp',
  \'coc-clangd',
  \'coc-phpls',
  \'coc-cmake',
  \'coc-go',
  \'coc-rls']

" UltiSnips
" Here are the snippets if you need more you can write them here
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips']

let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<d-tab>"

let g:snipMate = { 'snippet_version': 1 }

" vim-closetag
let g:closetag_filenames = '*.html,*.js,*.jsx,*.ts,*.tsx'

" Kite
"let g:kite_supported_languages = ['javascript', 'python', 'go']
