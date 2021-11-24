"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""AUTO UPDATE"""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup vim_cmd
  autocmd!
  autocmd BufWritePost Basic.vim nested source $MYVIMRC
  autocmd BufWritePost Mapping.vim nested source $MYVIMRC
  autocmd BufWritePost Plugin.vim nested source $MYVIMRC
  autocmd BufWritePost PluginSetUp.vim nested source $MYVIMRC
  autocmd BufWritePost Update.vim nested source $MYVIMRC
augroup END

