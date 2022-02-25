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
set encoding=UTF-8	" Add characters
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

" Autosave
" Autosave based on buffer
"autocmd CursorHold * update
" Autosave while writting
autocmd CursorHold,CursorHoldI * update

syntax enable		" Change the natural rgb

let g:polyglot_disabled = ['markdown']
