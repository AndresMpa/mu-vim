"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""PLUG INSTALLATION"""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin(expand('~/.config/nvim/plugged'))

"""""""""""""""""""""""""""""""""""""THEME"""""""""""""""""""""""""""""""""""""

" Bar
Plug 'ryanoasis/vim-devicons'                           " Icons for NERDTree
Plug 'vim-airline/vim-airline'                          " Bar theme
Plug 'vim-airline/vim-airline-themes'				            " Airline themes

" Nvim
"Plug 'morhetz/gruvbox', { 'as': 'gruvbox' }	            " Nvim theme
"Plug 'kamykn/dark-theme.vim'

"""""""""""""""""""""""""""""""""""""MOTION"""""""""""""""""""""""""""""""""""""

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }         " fzf install instructions
Plug 'christoomey/vim-tmux-navigator'				                              " Navigation between windows
Plug 'severin-lemaignan/vim-minimap'                                      " A minimap
Plug 'easymotion/vim-easymotion'						                              " Navigation in files
Plug 'haya14busa/incsearch.vim'							                              " Better way to look for words
Plug 'scrooloose/nerdtree'							                                  " Navigation between files
Plug 'junegunn/fzf.vim'                                                   " Better way to search files
Plug 'mileszs/ack.vim'                                                    " Navigation in projects

""""""""""""""""""""""""""""""CODE HELPERS & SYNTAX""""""""""""""""""""""""""""""

Plug 'neoclide/coc.nvim', {'branch': 'release'}   " Text editing support
Plug 'iamcco/markdown-preview.nvim'               " Markdown preview
Plug 'terryma/vim-multiple-cursors'               " Multicursor
Plug 'leafgarland/typescript-vim'                 " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'                   " JS and JSX syntax
Plug 'preservim/nerdcommenter'                    " Easy way to make commets
Plug 'pangloss/vim-javascript'                    " JavaScript support
Plug 'KabbAmine/vCoolor.vim'                      " Color picker for css
Plug 'sheerun/vim-polyglot'		                    " Syntax highligth for multiple languajes
Plug 'jparise/vim-graphql'                        " GraphQL syntax
Plug 'kovetskiy/sxhkd-vim'                        " Vim stuff for indent, highlight syntax and detect sxhkd
Plug 'Yggdroot/indentLine'                        " Identation helper (It shows the identation of functions, etc)
Plug 'rust-lang/rust.vim'                         " Support for Rust
Plug 'tpope/vim-fugitive'                         " Support to git commands
Plug 'mhinz/vim-signify'                          " Git diffs
Plug 'turbio/bracey.vim'                          " Vim live server
Plug 'tpope/vim-repeat'                           " Repat all the commands using
Plug 'ap/vim-css-color'                           " Show #fffffffff with colors
Plug 'z0mbix/vim-shfmt'                           " Identation for vim scripts
Plug 'jalvesaq/Nvim-R'                            " R support

""""""""""""""""""""""""""""""""""AUTOCOMPLETE"""""""""""""""""""""""""""""""""""""

Plug 'editorconfig/editorconfig-vim'              " It gives nvim a general editing config for identation
Plug 'jiangmiao/auto-pairs'                       " Autocomplete parentesis
Plug 'tpope/vim-surround'                         " It helps to 'CRUD' parentesis, comillas and tags
Plug 'alvan/vim-closetag'                         " Autocomplete tags
Plug 'sirver/ultisnips'                           " Snippers engine

""""""""""""""""""""""""""""""""""DATA TRACKING"""""""""""""""""""""""""""""""""""""

Plug 'wakatime/vim-wakatime'

call plug#end()
