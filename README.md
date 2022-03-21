![Mμ Vim](./.examples/muVim.png)

<div align="center">
  <p>
    <a href="https://github.com/AndresMpa/mu-nvim">
      <img
        src="https://img.shields.io/badge/-neovim-darkblue?style=for-the-badge&logo=neovim"
        alt="Neovim"
      />
    </a>
    <a href="https://github.com/AndresMpa/mu-nvim">
      <img
        src="https://img.shields.io/badge/-lua-purple?style=for-the-badge&logo=lua"
        alt="Lua Script"
      />
    </a>
    <a href="https://github.com/AndresMpa/mu-nvim">
      <img
        src="https://img.shields.io/badge/-bash-black?style=for-the-badge&logo=GNU%20Bash"
        alt="Bash Script"
      />
    </a>
  </p>
</div>



This is a NeoVim and Vim configuration, It has 3 versions actually, one of them is
just 1 .vim file, so it's really easy to use and modify; what you see in main branch
is more complicated and it's the main config, check the wiki if you want more information;
main config is based on lua, but there's a VimScript based on config. This repository
contains 3 different branches each one of them have a different config, choose anyone,
all of them should work. It's recommended to follow this "guide" based on project branches.

## Guidelines

### Sigle init.vim (Mini config)

[This configuration](https://github.com/AndresMpa/nvim-configuration/tree/singleFile)
is pretty usefull to take it as a template; This version have sincrohinzed with
"VimScript" branch, so functionalities there should work here too. Also
there is a basic tutorial where you can see how to make a vim or nvim file like this,
check the link [here](https://andresmpa.github.io/nvim-configuration/)

### VimScript (LTS version)

"VimScript" is a language that comes by default with vim/nvim in both of them it works;
[this version](https://github.com/AndresMpa/nvim-configuration/tree/singleFile) uses this
language to handle their characteristics, such as "modules", those modules make it a more
difficult to understand for beginners, also easier to mantein and extend

### Lua (Core version)

This is core editor version, used for working as Web developer, Editor maintenance... also
handling my OS editing, keep this version if you want the latest features, new features
will be added here first, then those will be implemented on other branches, this is the
fastest one version, the most complicated too

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

To check line by line what you are looking on a file, this configuration use a
"search engine", it means that you will need some extra software to make it works

- [the_silver_search](https://github.com/ggreer/the_silver_searcher)
- [Ack](https://beyondgrep.com/install/)

#### Live server like plugin

This is pretty useful for those who make web apps; follow step 1; if it doesn't
work, by default

- [Installation](https://github.com/turbio/bracey.vim#installation)

#### Markdown support

Follow these steps on your init.vim or .vimrc

```
:source %
<Space> + p + i
:call mkdp#util#install()
```

#### Bash support

For OS maintenance, Bash scripting is a good tool that's why this configuration
have support for it to make code easy to read, if you want support for that language
dependecy, you need:

- [shfmt](https://diarioinforme.com/como-usar-shfmt-para-formatear-mejor-los-scripts-de-shell/)

#### R support

This project has R support, for those cases when R is needed has been added an R plugin

- [R language](https://linuxize.com/post/how-to-install-r-on-ubuntu-20-04/)
- [Some utils](https://github.com/jamespeapen/Nvim-R/wiki/Installation)


## Quick Start

If you don't know to much about vim or nvim just follow the next steps:

### If you are using Linux or mac

```
git clone https://github.com/AndresMpa/mu-vim.git
cd mu-nvim/ && ./install.sh && exit
nvim
```

### If you are using Windows

```
cd C:\Users\$USER\AppData\Local\
move nvim nvim_old
git clone https://github.com/AndresMpa/mu-vim.git
move mu-nvim nvim
nvim
```

Once you make this, open nvim then:

```
:source %
<Space> + p + i
<Space> + p + u
```

That's it, done

---

## Apps

There's a couple of apps I recommend you to improve a little bit more your velocity, they are:

- [rofi](https://github.com/davatorium/rofi)
- [Ulauncher](https://ulauncher.io/)
- [Zeal](https://zealdocs.org/)
- [Vimium](https://addons.mozilla.org/es/firefox/addon/vimium-ff/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search)
- [Arch Linux](https://github.com/AndresMpa/dotfiles)

## Pats on the back

If you are reading this, it means that you want to improve your velocity, or you want to make
your own things so, if you start by nvim or vim It may be complicated, but just at the beginning
them you'll look like a professional "Ninja Dev": keep working constancy  conquer whatever

## Simiular projects

If this project doesn't match to you, you could also check:

  - [DoomVim](https://github.com/NTBBloodbath/doom-nvim)
  - [NvChad](https://github.com/NvChad/NvChad)
  - [LunarVim](https://github.com/LunarVim/LunarVim)

<div align="center">
  <p>
    Special thanks to @jx11r for documentation provided
  </p>
</div>
