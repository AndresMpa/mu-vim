""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""MAPPING""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader=" "			" Setting the leader key to space

" Settings commands

" easymotion
nmap <Leader>ss <Plug>(easymotion-s2)

" Files
nmap <Leader>sf :BLines<CR>

" incsearch
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)

" NERDTree
nmap <leader>n :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeToggle<CR>
nmap <leader>nc :NERDTreeToggleVCS<CR>

" fzf
nmap <Leader>ff :Ag<CR>
nmap <Leader>ft :FZF<CR>

" AcK
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

" Replace
nnoremap <leader>R :%s/_/_/gc

" vim-fugitive (git support)
nmap <Leader>gpl :Git pull<CR>
nmap <Leader>gps :Git push<CR>
nmap <Leader>gii :Git init<CR>
nmap <Leader>gsh :Git show<CR>
nmap <Leader>gbl :Git blame<CR>
nmap <Leader>gst :Git status<CR>
nmap <Leader>gc :Git commit<CR>
nmap <Leader>gaa :Git add --all<CR>
nmap <Leader>grv :Git remote -v<CR>

" Commands that need especification
nmap <Leader>ga :Git add<Space>
nmap <Leader>gsw :Git switch<Space>
nmap <Leader>gco :Git checkout<Space>
nmap <Leader>gcb :Git checkout -b<Space>
nmap <Leader>gll :Git pull origin<Space>
nmap <Leader>gpp :Git push origin<Space>

" To performe different actions
nnoremap <Leader>ggg :Git<Space>

" coc
nmap <silent>cd <Plug>(coc-definition)
nmap <silent>ct <Plug>(coc-type-definition)
nmap <silent>cg <Plug>(coc-implementation)
nmap <silent>cr <Plug>(coc-references)
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" repeat
"nmap <Plug>(RepeatUndo) U

" Plug
nmap <Leader>pc :PlugClean<CR>
nmap <Leader>pi :PlugInstall<CR>
nmap <Leader>pu :PlugUpdate<CR>
nmap <Leader>pd :PlugUpgrade<CR>

" Extras
nmap <Leader>w :w<CR>
nmap <Leader>q :q!<CR>
nmap <Leader>h :bdelete<CR>
nmap <Leader>j :bprevious<CR>
nmap <Leader>k :bnext<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>l :ls<CR>
nmap <Leader>vj :split<CR>
nmap <Leader>vk :vsplit<CR>
nnoremap <silent> <Leader>< :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>> :exe "resize " . (winheight(0) * 2/3)<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""FUNCTION"""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! HelpMapping()
  let info = [
        \"Current features",
        \"\n",
        \"\n",
        \"# Basics",
        \"\n",
        \"w -> Write",
        \"q -> Quite",
        \"h -> Close file",
        \"nj -> Previous",
        \"k -> Next",
        \"nl -> List",
        \"b -> Buffers",
        \"\n",
        \"\n",
        \"zf#j creates a fold from the cursor down # lines".
        \"zf/string creates a fold from the cursor to string"
        \"zj moves the cursor to the next fold"
        \"zk moves the cursor to the previous fold"
        \"zo opens a fold at the cursor"
        \"zO opens all folds at the cursor"
        \"zm increases the foldlevel by one"
        \"zM closes all open folds"
        \"zr decreases the foldlevel by one"
        \"zR decreases the foldlevel to zero — all folds will be open"
        \"zd deletes the fold at the cursor"
        \"zE deletes all folds"
        \"[z move to start of open fold"
        \"]z move to end of open fold"
        \"\n",
        \"\n",
        \"# File control",
        \"\n",
        \"vj -> Split horizontally",
        \"vk -> Split vertically",
        \"< -> Hide prompt",
        \"> -> Expand promt",
        \"\n",
        \"\n",
        \"# Motion mappings",
        \"\n",
        \"ss -> Search by line",
        \"sf -> Search by files",
        \"? or \ -> Search by characters",
        \"n -> Search with nerdtree",
        \"ff -> Search with ag (folders)",
        \"fs -> Search with fzf (files)",
        \"a -> Search using Ack",
        \"\n",
        \"\n",
        \"# Replace text",
        \"\n",
        \"R -> Replace a with b",
        \"\n",
        \"\n",
        \"# Git (Inmediate commands)",
        \"gpl -> Git pull",
        \"gps -> Git push",
        \"gii -> Git init",
        \"gsh -> Git show",
        \"gbl -> Git blame",
        \"gst -> Git status",
        \"gc -> Git commit",
        \"gaa -> Git add",
        \"grv -> Git remote",
        \"\n",
        \"# Git (Writting)",
        \"\n",
        \"ga  -> Git add",
        \"gsw -> Git switch",
        \"gco -> Git checkout",
        \"gcb -> Git checkout -b",
        \"gll -> Git pull",
        \"gpp -> Git push",
        \"ggg -> Git (General command)",
        \"\n",
        \"\n",
        \"# CoC",
        \"\n",
        \"cd -> Coc definition",
        \"ct -> Coc type",
        \"cg -> Coc implementation",
        \"cr -> Coc references",
        \"\n",
        \"# Formatter",
        \"\n",
        \"f -> Prettier",
        \"\n",
        \"\n",
        \"# Maintenance",
        \"\n",
        \"pc -> PlugClean",
        \"pi -> PlugInstall",
        \"pu -> PlugUpdate",
        \"pd -> PlugUpgrade"]

  for tip in info
    execute "echo tip"
  endfor
endfunction

nmap <Leader>hh :call HelpMapping()<CR>



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

function! OpenFileServer()
  let extention = expand('%:e')
  execute "echo extention"

  "Markdown Preview
  if extention == "md"
    execute "normal \<Plug>MarkdownPreviewToggle"
  endif

  "Preview html files
  if extention == "html"
    execute "!firefox %"
  endif

  " Execute python
  if extention == "py"
    execute "!python %"
  endif

  "Execute node
  if extention == "js"
    execute "!node %"
  endif

endfunction

nmap <Leader>x :call OpenFileServer()<CR>

function! OpenServer(flag)
  let message="Starting a developer server for: "
  execute "echo message"
  execute "echo a:flag"

  " Execute django server
  if a:flag == "django"
    execute ":terminal python manage.py runserver"
  endif

  "Start vue project
  if a:flag == "vue"
    execute ":terminal npm run serve"
  endif

endfunction

nmap <Leader>xd :call OpenServer("django")<CR>
nmap <Leader>xv :call OpenServer("vue")<CR>

function! TriggerIdentation()
  let extention = expand('%:e')

  if extention == "sh"
    "execute "normal \<Plug>(coc-codeaction)"
    execute ":Shfmt"
  else
    execute ":Prettier"
  endif
endfunction

nmap <leader>f :call TriggerIdentation()<CR>
