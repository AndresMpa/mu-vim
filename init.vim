let $vimcf = $HOME .. '/.config/nvim/.vim'

"Genertal config for nvim or vim
source $vimcf/Basic.vim

"Plugins that I'm using
source $vimcf/Plugin.vim


"Plugins set up
source $vimcf/setUp/style.vim
source $vimcf/setUp/navigation.vim
source $vimcf/setUp/completion.vim
source $vimcf/setUp/identation.vim

"Some auto command
source $vimcf/Autocommands.vim

"Mapping for vim acctions
source $vimcf/util/Extention.vim
source $vimcf/Mapping.vim

"Auto update
source $vimcf/Update.vim
