"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""NVIM SETTINGS"""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 
"""""""""""""""""""""""""""""""""""""LINES"""""""""""""""""""""""""""""""""""""

set sw=2		        " Replace tabs with X number of spaces
set number		      " Show the numbers on the left
set numberwidth=1	  " Set numbers width
set relativenumber	" It shows the current cursor line

"""""""""""""""""""""""""""""""""""""STYLE"""""""""""""""""""""""""""""""""""""

set ruler		        " It shows the bar down
set hidden          " It hides what is down on nvim commands
set showcmd		      " Show the commands you are using
set nobackup        " It can make coc work badly 
set showmatch		    " It shows the closing parentesis
set splitright      " Open new panes to the right
set cmdheight=1     " Better display for coc
set nowritebackup   " Neccessary for some coc servers
set encoding=utf-8	" Add characters
set updatetime=300  " Changing update time make coc works better

"""""""""""""""""""""""""""""""""""""MOUSE"""""""""""""""""""""""""""""""""""""

set title		              " It shows the file title
set mouse=a	  	          " It lets you use mous-e on the terminal
set visualbell            " Disable the fuc** bell
set clipboard=unnamedplus	" Keep what you copy on the clip-board

"""""""""""""""""""""""""""""""""""""STATUS"""""""""""""""""""""""""""""""""""""

set noshowmode            " This space is needed
set laststatus=2          " Allways show your status
set nocompatible          " Needed for polyglot
set belloff+=ctrlg        " if vim beeps during completion

"""""""""""""""""""""""""""""""""""""PREFIXES"""""""""""""""""""""""""""""""""""""

set completeopt+=noselect
set completeopt+=noinsert
set completeopt+=menuone

let g:polyglot_disabled = ['markdown']

syntax enable		" Change the natural rgb

call plug#begin(expand('~/.config/nvim/plugged'))

"""""""""""""""""""""""""""""""""""""THEME"""""""""""""""""""""""""""""""""""""

" Bar
Plug 'ryanoasis/vim-devicons'                           " Icons for NERDTree
Plug 'vim-airline/vim-airline'                          " Bar theme
Plug 'vim-airline/vim-airline-themes'				            " Airline themes

" Nvim
Plug 'morhetz/gruvbox', { 'as': 'gruvbox' }	            " Nvim theme

"""""""""""""""""""""""""""""""""""""MOTION"""""""""""""""""""""""""""""""""""""

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }   " fzf install instructions
Plug 'christoomey/vim-tmux-navigator'				                        " Navigation between windows
Plug 'easymotion/vim-easymotion'						                        " Navigation in files
Plug 'haya14busa/incsearch.vim'							                        " Better way to look for words
Plug 'scrooloose/nerdtree'							                            " Navigation between files
Plug 'junegunn/fzf.vim'                                             " Better way to search files

""""""""""""""""""""""""""""""CODE HELPERS & SYNTAX""""""""""""""""""""""""""""""

Plug 'neoclide/coc.nvim', {'branch': 'release'}   " Text editing support
Plug 'terryma/vim-multiple-cursors'               " Multicursor
Plug 'preservim/nerdcommenter'                    " Easy way to make commets
Plug 'sheerun/vim-polyglot'		                    " Syntax highligth for multiple languajes
Plug 'Yggdroot/indentLine'                        " Identation helper (It shows the identation of functions, etc)
Plug 'tpope/vim-fugitive'                         " Support to git commands
Plug 'mhinz/vim-signify'                          " Git diffs
Plug 'tpope/vim-repeat'                           " Repat all the commands using .

""""""""""""""""""""""""""""""""""AUTOCOMPLETE"""""""""""""""""""""""""""""""""""""

Plug 'jiangmiao/auto-pairs'                       " Autocomplete parentesis
Plug 'tpope/vim-surround'                         " It helps to 'CRUD' parentesis, comillas and tags
Plug 'alvan/vim-closetag'                         " Autocomplete tags
Plug 'honza/vim-snippets'                         " Snippers support 
Plug 'sirver/ultisnips'                           " Snippers engine

call plug#end()

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
  let g:airline_left_sep = ''
  let g:airline_right_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.whitespace = 'Ξ'
  let g:airline_symbols.paste = "\uE0CE"
  let g:airline_symbols.linenr = "\uE0CC"
  let g:airline#extensions#branch#prefix = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol = '⊘'
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol = "\uE0CF"
  let g:airline#extensions#tabline#left_alt_sep = ''
endif

" Nvim THEME
colorscheme gruvbox

let g:gruvbox_color_column='bg0'
let g:gruvbox_contrast_dark='hard'

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

""""""""""""""""""""""""""""""""""""""CODE HELPERS & SYNTAX""""""""""""""""""""""""""""""""""""""""

" coc
"" Prettier, Emmet, HTML, CSS/Less/Sass, Json, JS/TS, Vue, Sh, Rust, Ruby, R
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
  \'coc-r-lsp']

" Multicursor
let g:multi_cursor_start_word_key = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key = 'g<C-n>'
let g:multi_cursor_select_all_key = 'g<A-n>'
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

" UltiSnips
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips']
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<d-tab>"

""""""""""""""""""""""""""""""""""AUTOCOMPLETE"""""""""""""""""""""""""""""""""""""

" vim-closetag
let g:closetag_filenames = '*.html,*.js,*.jsx,*.ts,*.tsx'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Auto-close pop up helpers
autocmd CompleteDone * if !pumvisible() | pclose | endif

" coc
autocmd FileType scss setl iskeyword+=@-@
command! -nargs=0 Prettier :CocCommand prettier.formatFile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""MAPPING""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader=" "			" Setting the leader key to space

" Settings commands

" easymotion
nmap <Leader>s <Plug>(easymotion-s2)

" incsearch
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)

" NERDTree
nmap <leader>n :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeToggle<CR>
nmap <leader>nc :NERDTreeToggleVCS<CR>

" fzf
nmap <Leader>ff :FZF<CR>
nmap <Leader>ft :Filetypes<CR>

" vim-fugitive (git support)
nmap <Leader>gii :Git init<CR>
nmap <Leader>gsh :Git show<CR>
nmap <Leader>gc :Git commit<CR>
nmap <Leader>gst :Git status<CR>
nmap <Leader>gaa :Git add --all<CR>
nmap <Leader>grv :Git remote -v<CR>
nmap <Leader>gra :Git remote --add<CR>
" Replace <oringin> <dev> to other branch if neccessary
nmap <Leader>gpl :Git pull origin dev<CR>
nmap <Leader>gps :Git push origin dev<CR>

" coc
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gt <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)
nmap <leader>f :Prettier<CR>
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" repeat
if empty(mapcheck("<Plug>(RepeatUndo)"))
  nnoremap <Plug>(RepeatUndo) U
endif

" Plug
nmap <Leader>pc :PlugClean<CR>
nmap <Leader>pi :PlugInstall<CR>

" Extras
nmap <Leader>w :w<CR>
nmap <Leader>q :q!<CR>
nmap <Leader>h :ls<CR>
nmap <Leader>j :bnext<CR>
nmap <Leader>l :bdelete<CR>
nmap <Leader>k :bprevious<CR>
nmap <Leader>vj :split<CR>
nmap <Leader>vk :vsplit<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 2/3)<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""TERMINAL"""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Function
function! OpenTerminal()
  " move to right most buffer
  execute "normal \<C-l>"

  let bufNum = bufnr("%")
  let bufType = getbufvar(bufNum, "&buftype", "not found")

  if bufType == "terminal"
    " close existing terminal
    execute "q"
  else
    " open terminal
    execute "vsp term://zsh"

    " turn off numbers
    execute "set nonu"
    execute "set nornu"

    " toggle insert on enter/exit
    silent au BufLeave <buffer> stopinsert!
    silent au BufWinEnter,WinEnter <buffer> startinsert!

    " set maps inside terminal buffer
    execute "tnoremap <buffer> <C-h> <C-\\><C-n><C-w><C-h>"
    execute "tnoremap <buffer> <C-t> <C-\\><C-n>:q<CR>"

    startinsert!
  endif
endfunction

