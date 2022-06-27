let $vimcf = $HOME .. '/.config/nvim/.vim'

"Genertal config for nvim or vim
source $vimcf/Basic.vim

"Plugins that I'm using
source $vimcf/Plugin.vim

"Plugins set up
source $vimcf/PluginSetUp.vim

"Mapping for vim acctions
source $vimcf/util/Extention.vim
source $vimcf/Mapping.vim

"Auto update
source $vimcf/Update.vim
