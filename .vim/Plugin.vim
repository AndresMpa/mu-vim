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
Plug 'morhetz/gruvbox', { 'as': 'gruvbox' }	            " Nvim theme
"Plug 'kamykn/dark-theme.vim'

" Start screen
Plug 'mhinz/vim-startify'

"""""""""""""""""""""""""""""""""""""MOTION"""""""""""""""""""""""""""""""""""""

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }         " fzf install instructions
Plug 'christoomey/vim-tmux-navigator'				                              " Navigation between windows
Plug 'severin-lemaignan/vim-minimap'                                      " A minimap
Plug 'easymotion/vim-easymotion'						                              " Navigation in files
Plug 'haya14busa/incsearch.vim'							                              " Better way to look for words
Plug 'scrooloose/nerdtree'							                                  " Navigation between files
Plug 'junegunn/fzf.vim'                                                   " Better way to search files
Plug 'mileszs/ack.vim'                                                    " Navigation in projects

""""""""""""""""""""""""""""""IDENTATION & SYNTAX""""""""""""""""""""""""""""""

Plug 'neoclide/coc.nvim', {'branch': 'release'}   " Text editing support
Plug 'leafgarland/typescript-vim'                 " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'                   " JS and JSX syntax
Plug 'pangloss/vim-javascript'                    " JavaScript support
Plug 'sheerun/vim-polyglot'		                    " Syntax highligth for multiple languajes
Plug 'jparise/vim-graphql'                        " GraphQL syntax
Plug 'kovetskiy/sxhkd-vim'                        " Vim stuff for indent, highlight syntax and detect sxhkd
Plug 'Yggdroot/indentLine'                        " Identation helper (It shows the identation of functions, etc)
Plug 'rust-lang/rust.vim'                         " Support for Rust
Plug 'tpope/vim-fugitive'                         " Support to git commands
Plug 'z0mbix/vim-shfmt'                           " Identation for bash scripts
Plug 'jalvesaq/Nvim-R'                            " R support


""""""""""""""""""""""""""""""""""""""UTILITIES"""""""""""""""""""""""""""""""""""""

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} " Markdown preview
Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}                                           " Vim live server
Plug 'terryma/vim-multiple-cursors'                                                                       " Multicursor
Plug 'preservim/nerdcommenter'                                                                            " Easy way to make commets
Plug 'wakatime/vim-wakatime'                                                                              " Data tracking
Plug 'KabbAmine/vCoolor.vim'                                                                              " Color picker for css
Plug 'mhinz/vim-signify'                                                                                  " Git diffs
Plug 'ap/vim-css-color'                                                                                   " Show #fffffffff with colors
Plug 'tpope/vim-repeat'                                                                                   " Repat all the commands using dot key


""""""""""""""""""""""""""""""""""AUTOCOMPLETE"""""""""""""""""""""""""""""""""""""

Plug 'editorconfig/editorconfig-vim'              " It gives nvim a general editing config for identation
Plug 'jiangmiao/auto-pairs'                       " Autocomplete parentesis
Plug 'tpope/vim-surround'                         " It helps to 'CRUD' parentesis, comillas and tags
Plug 'alvan/vim-closetag'                         " Autocomplete tags
Plug 'sirver/ultisnips'                           " Snippers engine

call plug#end()
