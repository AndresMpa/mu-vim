"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""PLUG SETTINGS"""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""STYLE""""""""""""""""""""""""""""""""""""""""

" vim-airline

let g:airline_theme = 'cool'
let g:airline_skip_empty_sections = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#virtualenv#enabled = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
   " Using powerline symbols, it changes some icons
   "   ﯇ ﯑ ﲋ ⊘ ﳐ ﳁ ﳂ ﴣ 謹 﫸 陼 靖 𥳐 𥉉
   " 龎 𧻓 﫠 﫟 並 療 李 僚 寮 料 惡 祉 祈
   " ﮆ ﮇ ﰧ ﰦ  ﱞ  ﱟ 數 ﯊
  let g:airline_left_sep = ''
  let g:airline_right_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.paste = '﮶'
  let g:airline_symbols.colnr = 'ﬡ'
  let g:airline_symbols.crypt = 'ﲘ'
  let g:airline_symbols.spell = 'ﴣ'
  let g:airline_symbols.branch = ''
  let g:airline_symbols.dirty = ' 數'
  let g:airline_symbols.linenr = ' 料'
  let g:airline_symbols.readonly = '﯎'
  let g:airline_symbols.notexists = ' 𥉉'
  let g:airline_symbols.whitespace = '𥳐'
  let g:airline_symbols.maxlinenr = ' 寮'
  let g:airline#extensions#paste#symbol = '﮶'
  let g:airline#extensions#branch#prefix = '⤴'
  let g:airline#extensions#readonly#symbol = 'ﰸ'
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#linecolumn#prefix = '﯑'
  let g:airline#extensions#tabline#left_alt_sep = ''
endif

" Nvim THEME
"colorscheme gruvbox

"let g:gruvbox_color_column='bg0'
"let g:gruvbox_contrast_dark='hard'

"colorscheme darktheme

""""""""""""""""""""""""""""""""""""""NAVIGATION""""""""""""""""""""""""""""""""""""""""

" incsearch
let g:incsearch#auto_nohlsearch = 1 " Remove the highligth after search

" NERDTree
let NERDTreeMouseMode=1             " let you use the mouse
let NERDTreeQuitOnOpen=1            " quit nerdtree when you open a file
let NERDTreeShowHidden=1            " show files or dir hidden by '.'

" fzf
" FZF will keep the history here
let g:fzf_history_dir = '~/.local/share/fzf-history'
" Options while opening files with FZF
let g:fzf_action = {
  \ 'ctrl-o': 'tab split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-s': 'split'
  \}

" Ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

""""""""""""""""""""""""""""""""""""""CODE HELPERS & SYNTAX""""""""""""""""""""""""""""""""""""""""

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

" Multicursor
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_select_all_key = 'g<A-n>'
let g:multi_cursor_start_word_key = '<C-n>'
let g:multi_cursor_start_key = 'g<C-n>'
let g:multi_cursor_next_key = '<C-n>'
let g:multi_cursor_prev_key = '<C-p>'
let g:multi_cursor_skip_key = '<C-x>'
let g:multi_cursor_quit_key = '<Esc>'

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


" UltiSnips
" Here are the snippets if you need more you can write them here
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips']

let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<d-tab>"


""""""""""""""""""""""""""""""""""AUTOCOMPLETE"""""""""""""""""""""""""""""""""""""

" vim-closetag
let g:closetag_filenames = '*.html,*.js,*.jsx,*.ts,*.tsx'

""""""""""""""""""""""""""""""""""AUTOCOMMANDS""""""""""""""""""""""""""""""""""""

au BufNewFile,BufRead /*.rasi setf css
"au BufNewFile,BufRead *.html set filetype=htmldjango

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

" Kite
"let g:kite_supported_languages = ['javascript', 'python', 'go']
