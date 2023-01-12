" VIM-AIRLINE

let g:airline_theme = 'badwolf'
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

" THEME
colorscheme gruvbox

let g:gruvbox_color_column='bg0_h'
let g:gruvbox_contrast_dark='hard'
