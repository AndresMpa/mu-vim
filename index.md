## My neovim configuration

### Quick start

Step zero, the easiest way to start with this is to download main branch by
clicking the button above, then use:

```
$ cd My-NVIM-configuration
$ ./install.sh
```

Then, follow the instructions an enjoy it

### A longer way to make this

**First step**

It's import to understand that you are making a custom configuration, it
means that you are the person who is going to maintain your configuration
files, whereas other options like downloading someone else configuration
(Like mine) means that you are not going to be part of maintaining process,
unless you modify your "init.vim" or "vimrc" local files; these options are
less stressful some way, but at the same time it doesn't let you options to
improve your editor tool and if you want to use a terminal editor without
this you are losing the best part of it so, let's start with this by the
tutorial vim tutorial

---

#### Vim tutorial and cheatseet

This is for beginners, so you can skip this item if you already know how
to work why vim or neovim, otherwise if you prefer a video tutorial, this
is a free neovim tutorial at
[Udemy](https://www.udemy.com/course/vim-aumenta-tu-velocidad-de-desarrollo/)

> Tip:
> vim and neovim take words as objects, when you understand this you will
> go faster

#### Motion

| Action                                               | Command           |
| ---------------------------------------------------- | ----------------- |
| Move up (Add a number to jump # lines, default 1)    | #k or arrow up    |
| Move down (Add a number to jump # lines, default 1)  | #j or arrow down  |
| Move left (Add a number to jump # lines, default 1)  | #l or arrow left  |
| Move right (Add a number to jump # lines, default 1) | #h or arrow right |

#### Writting

| Action  | Command               |
| ------- | --------------------- |
| Insert  | i or a or o or s      |
| Replace | r or R                |
| Visual  | v                     |
| Copy    | y                     |
| Paste   | p or P                |
| Undo    | u                     |
| Delete  | x or #d + space or dd |
| Search  | # + n or /query + n   |

#### Lines

| Action                                             | Command           |
| -------------------------------------------------- | ----------------- |
| Move to the end of a word # tines (Default 1)      | #e                |
| Move forward a number # of words (Default 1)       | #w                |
| Move backward a number # of words (Default 1)      | #b                |
| Move forward a WORD (any non-whitespace characters | W                 |
| Move the end of current line                       | $                 |
| Move to the beginning of the line                  | 0 or vertical bar |
| Move to the first non-blank character of the line  | ^                 |
| Move to # column                                   | # + Vertical bar  |

#### Jumping

| Action                                                | Command                       |
| ----------------------------------------------------- | ----------------------------- |
| Jump to beginning of file                             | gg or 1G                      |
| Jump to end of file                                   | G                             |
| Jump to any # line                                    | #G                            |
| Jump # screen lines in direction (up,down,left,right) | #g + direction {j, k, h, l}   |
| Move # pages up                                       | # + page up or # + ctrl + b   |
| Move # pages dowm                                     | # + page dowm or # + ctrl + f |
| Jump to the top of the screen                         | H                             |
| Jump to the middle of the screen                      | M                             |
| Jump to the bottom of the screen                      | B                             |
| Jump between sentences                                | ( or )                        |
| Jump between paragraph                                | { or }                        |
| Jump between closing brace                            | %                             |

#### Scrolling

| Action             | Command  |
| ------------------ | -------- |
| Scroll 50% up      | ctrl + d |
| Scroll 50% down    | ctrl + u |
| Scroll 100% up     | ctrl + f |
| Scroll 100% down   | ctrl + b |
| Scroll 1 line up   | ctrl + e |
| Scroll 1 line down | ctrl + y |

#### Marks

| Action                                                               | Command |
| -------------------------------------------------------------------- | ------- |
| Set mark x at the current cursor position                            | mx      |
| Jump to the beginning of the line of mark                            | 'x      |
| Jump to the cursor position of mark x                                | `x      |
| Return to the line where the cursor was before the latest jump       | "       |
| Return to the cursor position before the latest jump (undo the jump) | ``      |
| Jump to the last-changed line                                        | '.      |
| Jump to last edited                                                  | g;      |

---

### Your own configuration file

**Step two**

As you can see neovim by default is quite simple, we make look and feel more confortable
by adding a configuration file, so follow the next steps on your terminal (This uses
nvim as example)

> Note:
> If you are using vim just type: ´cd && vim .vimrc´

´´´
$ cd
$ mkdir .config
$ cd .config
$ mkdir nvim
$ touche init.vim
$ nvim init.vim
´´´

Now you should see an empty file .vim extention, that file is going to be your neovim
configuration file, now; let's make a couple of changes to default neovim and vim
look, type the following then close the editor and open again that file that you created

´´´
" Some static options
set sw=2 " Replace tabs with X number of spaces
set title " It shows the file title

" Number on the left
set number " Show the numbers on the left
set numberwidth=1 " Set numbers width
set relativenumber " It shows the current cursor line

" Mouse
set mouse=a " It lets you use mous-e on the terminal
set clipboard=unnamedplus " Keep what you copy on the clip-board
´´´

This is a really basic configuration that only uses "set" statement... As you can see
the single " is used for comments, taking in consideration what you copy paste, I suggest
you to commet what you did, trust me you will forget what those things do... As you can see
now your editor neovim or vim should look different, that's because of your sets but, we can
add some more configurations to this file, let's try something a little bit more complicated

### Plugins

**Step three**

Now that you know how to move in files using neovim and vim, let's start to make it easier;
as you should know neovim and vim let you use a lot a plugins, those plugins make our
lives as developers easier, that why when use neovim we can see a improment in our
code development velocity, there are several differences between developers and that's why
each one of us have to make different task while developing something, it means that
we have to use different tools like languages, enviroments, etc; but there are some
tools that were made for general purpose

### Plugins managers

There something call "plugin manage" that's a piece of software that give you a sort way
to install plugins, those plugins generally come from GitHub, that why I recommend you to
use "Plug", but there are some other options that I'm leaving in the next list:

- [vim-plug](https://github.com/junegunn/vim-plug)
- [dein.vim](https://github.com/Shougo/dein.vim)
- [brew.nvim](https://github.com/zgpio/brew.nvim)
- [packer.vim](https://github.com/wbthomason/packer.nvim)
- [Paq](https://github.com/savq/paq-nvim)

Those are the plugin managers that I know in this case, just choose one and continue typing
the following (This case I took vim-plug as example):

´´´
" The sets you wrote before

" Plugin manager donwloads dir
call plug#begin(expand('~/.config/nvim/plugged'))

" Some plugins

´´´

Using vim I suggest to user make a dir inside .config like this

´´´
" The sets you wrote before

" Plugin manager donwloads dir
call plug#begin(expand('~/.config/plugged'))

" Some plugins

´´´

It surely change if you use another plugin manager

---

### Plugins

Now that you have a plugin manager let's start with basics, there are a lot of plugins
there on internet and we have to hunt some of them... But, I have some of them that
will help you a lot, I have already talked to you abot those plugins that were made
for general prupose, let's use some of them

- A languages support
- Something to use git
- A cool we to navigate between istances of nvim or vim
- Something to navigate between file
- Something to search words inside our files
- A better color schema

There are a lot of things that we need to set now, don't you think so? Well, with our
plugin manager we can make this relatively easy, in this example we will use:

´´´
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Text editing support
Plug 'tpope/vim-fugitive' " Support to git commands
Plug 'christoomey/vim-tmux-navigator' " Navigation between windows
Plug 'scrooloose/nerdtree' " Navigation between files
Plug 'haya14busa/incsearch.vim' " Better way to look for words
Plug 'morhetz/gruvbox', { 'as': 'gruvbox' } " Nvim theme
Plug 'vim-airline/vim-airline' " Bar theme
´´´

Then, esc + esc + : + PlugInstall this will install all the repositories that you have
written

Well know you have a basic IDE in you terminal but there are some extra configurations
that we can set, so let's start by our languages support, add the following lines after
the plugins

´´´
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
´´´

Then, esc + esc + : + CocInstall this will install CoC dependencies

What you have written is called languages server support those are extentions for
CoC the first plugin that you installed

Now, let's add some other configurations for our plugins:

´´´
" NERDTree
let NERDTreeMouseMode=1 " let you use the mouse
let NERDTreeQuitOnOpen=1 " quit nerdtree when you open a file
let NERDTreeShowHidden=1 " show files or dir hidden by '.'

" incsearch
let g:incsearch#auto_nohlsearch = 1 " Remove the highligth after search

" Nvim THEME
colorscheme gruvbox

let g:gruvbox_color_column='bg0'
let g:gruvbox_contrast_dark='hard'

colorscheme darktheme

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
´´´

Take a minute to read those configurations if you want, but I can say that
that's the most common way to set those plugins, it might be a little bit
complicated at the beginning, but it's easy to understand.

### Mapping

**Last step**

Well, we will finish with this particular tool in nvim and vim; "mapping"
is basically use a combination of key that automates something let's map
our plugins

´´´

" coc
nmap <silent>cd <Plug>(coc-definition)
nmap <silent>ct <Plug>(coc-type-definition)
nmap <silent>cg <Plug>(coc-implementation)
nmap <silent>cr <Plug>(coc-references)
nmap <leader>f :Prettier<CR>
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" vim-fugitive (git support)
nmap <Leader>gii :Git init<CR>
nmap <Leader>gsh :Git show<CR>
nmap <Leader>gbl :Git blame<CR>
nmap <Leader>gcm :Git commit<CR>
nmap <Leader>gst :Git status<CR>
nmap <Leader>gaa :Git add --all<CR>
nmap <Leader>grv :Git remote -v<CR>
" Replace <oringin> <dev> to other branch if neccessary
nmap <Leader>gpl :Git pull origin dev<CR>
nmap <Leader>gps :Git push origin dev<CR>
" Commands that need especification
nmap <Leader>gck :Git check<Space>
nmap <Leader>gccaa :Git add<Space>
nmap <Leader>gnb :Git check -b<Space>
nmap <Leader>gccpl :Git pull origin<Space>
nmap <Leader>gccps :Git push origin<Space>

" NERDTree
nmap <leader>n :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeToggle<CR>
nmap <leader>nc :NERDTreeToggleVCS<CR>

" incsearch
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)

" Extras
nmap <Leader>w :w<CR>
nmap <Leader>q :q!<CR>
nmap <Leader>h :bdelete<CR>
nmap <Leader>j :bprevious<CR>
nmap <Leader>k :bnext<CR>
nmap <Leader>l :ls<CR>
nmap <Leader>vj :split<CR>
nmap <Leader>vk :vsplit<CR>
nmap <Leader>sf :BLines<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) _ 3/2)<CR>
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) _ 2/3)<CR>
´´´

You have mapped your plugins, quite simple, right? Well, those are examles
you can add more plugins if you want or some way you can remove some maps

### Can I use a terminal inside the terminal?

´´´
" Note: I took this function from https://github.com/nschurmann/configs/blob/master/.vim/maps.vim

" Function
function! OpenTerminal()
" move to right most buffer
execute "normal \<C-l>"
execute "normal \<C-l>"
execute "normal \<C-l>"
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
    execute "tnoremap <buffer> <C-\\><C-\\> <C-\\><C-n>"

    startinsert!

endif
endfunction
nnoremap <C-t> :call OpenTerminal()<CR>
´´´
