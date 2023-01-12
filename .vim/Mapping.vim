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
nmap <leader>n :NERDTreeToggleVCS<CR>

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
" Use <TAB> to trigger completion.
inoremap <silent><expr> <S-TAB>
      \ coc#pum#visible() ? coc#pum#prev(1) :
      \ coc#refresh()
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ coc#refresh()

" repeat
nmap U <C-r>

" vCoolor
nmap <Leader>r :VCoolIns ra<CR>

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
nmap <leader>H :%bd\|e#\|bd#<cr>
nnoremap <silent> <Leader>< :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>> :exe "resize " . (winheight(0) * 2/3)<CR>


" Extentions
nmap <Leader>hh :call HelpMapping()<CR>
nmap <Leader>x :call OpenFileServer()<CR>

nmap <Leader>xd :call OpenServer("django")<CR>
nmap <Leader>xv :call OpenServer("vue")<CR>

nmap <leader>f :call TriggerIdentation()<CR>

nnoremap <C-t> :call OpenTerminal()<CR>
