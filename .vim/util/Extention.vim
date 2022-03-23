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

function! OpenFileServer()
  let extention = expand('%:e')
  execute "echo extention"

  "Markdown Preview
  if extention == "md"
    execute "normal \<Plug>MarkdownPreviewToggle"
  endif

  "Preview html files
  if extention == "html"
    execute ":Bracey"
  endif

  " Execute python
  if extention == "py"
    execute "!python %"
  endif

  "Execute node
  if extention == "js"
    execute "!node %"
  endif

  "Execute node
  if extention == "sh"
    execute "!bash %"
  endif
endfunction

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

function! TriggerIdentation()
  let extention = expand('%:e')

  if extention == "sh"
    "execute "normal \<Plug>(coc-codeaction)"
    execute ":Shfmt"
  else
    execute ":Prettier"
  endif
endfunction
