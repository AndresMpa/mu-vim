![Mμ Vim](./.examples/muVim.png)

![neovim](https://img.shields.io/badge/-neovim-darkblue?style=for-the-badge&logo=neovim)
![lua](https://img.shields.io/badge/-lua-purple?style=for-the-badge&logo=lua)
![Bash](https://img.shields.io/badge/-bash-black?style=for-the-badge&logo=GNU%20Bash)

This repository contains 3 different branches each one of them have a different
config, choose anyone, all of them should work. I recommend to follow this "guide"
based on my branches.

## Guide lines

### Sigle init.vim (Mini config)

[This configuration](https://github.com/AndresMpa/nvim-configuration/tree/singleFile)
is pretty usefull to take it as a template; I've been mainteining it sincrohinzed with
"VimScript" branch, so also the functionalities I have there should work here too. Also
I made a basic tutorial where you can see how to make a vim or nvim file like this,
check the link [here](https://andresmpa.github.io/nvim-configuration/)

### VimScript (LTS version)

"VimScript" is the language that comes by default with vim/nvim in both of them it works;
[this version](https://github.com/AndresMpa/nvim-configuration/tree/singleFile) uses this
language to handle their characteristics, such as "modules", those modules make it a little
bit more difficult to understand, but also easier to mantein and extend

### Lua (Core version)

This is my core editor, I use this as my mine editor for working as Web developer, also
handling my OS editing, keep this version if you want my last features, I create new featues
here then I move them to my previous versions, this is the fastest one also the most complicated

#### Take a look

![nvim_0](./.examples/nvim_0.png)
![nvim 1](./.examples/nvim_1.png)
![nvim_2](./.examples/nvim_2.png)
![nvim_3](./.examples/nvim_3.png)
![nvim_4](./.examples/nvim_4.png)

## Prerequisites

If you want to use Lua you need [nvim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
otherwise [vim](https://www.vim.org/download.php) should be enough,
![Lua itself](https://www.tecmint.com/install-lua-in-centos-ubuntu-linux/),, then it's on you
to install some other features

#### General dependencies

### Lua

- As plugin manager [packer](https://github.com/wbthomason/packer.nvim#quickstart)

### Optional

#### Search engine

I'm pretty lazy to check line by line what I'm looking on a file, so I use a
"search engine", this means that I need to extra software to make that work

- [the_silver_search](https://github.com/ggreer/the_silver_searcher)
- [Ack](https://beyondgrep.com/install/)

#### Live server like plugin

This is pretty usefull for those who make web apps; follow step 1; if it doesn't
work by default

- [Installation](https://github.com/turbio/bracey.vim#installation)

#### Markdown support

Follow these steps on your init.vim or .vimrc

```
:source %
:PluginInstall
:call mkdp#util#install()
```

#### Bash support

Since I use a custom OS, I use a lot bash scripting, that why I saw the necessity of
using a tool to make my code more easy to read, that dependecy need of:

- [shfmt](https://diarioinforme.com/como-usar-shfmt-para-formatear-mejor-los-scripts-de-shell/)

#### R support

Sometimes I use R, for those cases I added an R plugin

- [R language](https://linuxize.com/post/how-to-install-r-on-ubuntu-20-04/)
- [Some utils](https://github.com/jamespeapen/Nvim-R/wiki/Installation)


## Quick Start

If you don't know to much about vim or nvim just follow the next steps:

### If you are using Linux or mac

```
git clone https://github.com/AndresMpa/nvim-configuration.git
cd nvim-configuration/ && ./install.sh && exit
nvim
```

### If you are using Windows

```
cd C:\Users\$USER\AppData\Local\nvim
move nvim nvim_old
git clone https://github.com/AndresMpa/nvim-configuration.git
move nvim-configuration nvim
```

---

## Apps

There's a couple of apps I recommend you to improve a little bit more your velocity, they are:

- [rofi](https://github.com/davatorium/rofi)
- [Ulauncher](https://ulauncher.io/)
- [Zeal](https://zealdocs.org/)
- [Vimium](https://addons.mozilla.org/es/firefox/addon/vimium-ff/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search)
- [Arch Linux](https://github.com/AndresMpa/dotfiles)

## Pats on the back

If you are reading this it means that you want to improve your velocity or you want to make your own things so, if you start by nvim or vim It may by a little bit complicated but just at the beginning them you'll look like a professional "Ninja Dev"
