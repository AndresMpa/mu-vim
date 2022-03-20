# My nvim configuration

This repository contains 3 different branches each one of them have a different
config, choose anyone, all of them should work. I recommend to follow this "guide"
based on my branches.

## Guide lines

### Sigle init.vim

[This configuration](https://github.com/AndresMpa/nvim-configuration/tree/singleFile)
is pretty usefull to take it as a template; I've been mainteining it sincrohinzed with
"VimScript" branch, so also the functionalities I have there should work here too. Also
I made a basic tutorial where you can see how to make a vim or nvim file like this,
check the link [here](https://andresmpa.github.io/nvim-configuration/)

### VimScript (Core version)

"VimScript" is the language that comes by default with vim/nvim in both of them it works;
[this version](https://github.com/AndresMpa/nvim-configuration/tree/singleFile) uses this
language to handle their characteristics, such as "modules", those modules make it a little
bit more difficult to understand, but also easier to mantein and extend

### Lua version (Working on this)

I'm moving to lua; please check [core version]()

#### Take a look

![nvim_0](./.examples/nvim_0.png)
![nvim 1](./.examples/nvim_1.png)
![nvim_2](./.examples/nvim_2.png)
![nvim_3](./.examples/nvim_3.png)

## Prerequisites

If you want to use Lua you might need [nvim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
otherwise [vim](https://www.vim.org/download.php) should be enough

#### General dependencies

### Lua

- As plugin manager [packer](https://github.com/wbthomason/packer.nvim#quickstart)

#### Search engine

- [the_silver_search](https://github.com/ggreer/the_silver_searcher)
- [Ack](https://beyondgrep.com/install/)

#### Bash support

- [shfmt](https://snapcraft.io/install/shfmt/ubuntu)

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
