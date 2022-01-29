# My nvim configuration

I made a basic tutorial where you can see how to make a vim or nvim file like this, check the link [here](https://andresmpa.github.io/nvim-configuration/)

## Note:

Previous version using only one file can be [find here](https://github.com/AndresMpa/nvim-configuration/tree/singleFile), I'll mantein it for a while

> Tip #1
> I really like web dev so this configuration is focus on that stuff anyway, everything have been well documented, so you can take it just a model, if you want to make your own config check about ["CoC"](https://github.com/neoclide/coc.nvim) if want to add more languages support

> Tip #2
> You can use my [init.vim file](https://github.com/AndresMpa/nvim-configuration/blob/singleFile/init.vim) in a .vimrc file if you want, almost everything works, but it may be necessary to change or replace a couple of things

![nvim](./.examples/nvim_0.png)
![nvim](./.examples/nvim_1.png)
![nvim](./.examples/nvim_2.png)
![nvim](./.examples/nvim_3.png)
![nvim](./.examples/nvim_4.png)

[Example from YouTube](https://youtu.be/9L-k6n9SQds)

## Prerequisites

You will need [npm](https://www.npmjs.com/get-npm) (or [yarm](https://classic.yarnpkg.com/en/docs/install/#debian-stable)) for some CoC services (It means that you'd need [nodejs](https://nodejs.org/es/download/)) and [nvim](https://github.com/neovim/neovim/wiki/Installing-Neovim) or [vim](https://www.vim.org/download.php) itself, if you want the complete search engine, you will also need [the_silver_search](https://github.com/ggreer/the_silver_searcher) and [Ack](https://beyondgrep.com/install/), if you bash support install shfmt

## Quick Start

If you don't know to much about vim or nvim just follow the next steps:

### If you are using Linux or mac

```
git clone https://github.com/AndresMpa/My-NVIM-configuration.git
cd nvim-configuration/ && ./install.sh && exit
nvim
```

### If you are using Windows

```
cd C:\Users\$USER\AppData\Local\nvim
move nvim nvim_old
git clone https://github.com/AndresMpa/nvim-configuration/tree/singleFile
move nvim-configuration nvim
```

#### Note:

If you feel lost inside nvim or vim and you are using my config, just press "space + h + h"

Now you must being on neovim (or vim) just make the following commands to install the plugins and that stuff (You may need to install [Plug](https://github.com/junegunn/vim-plug))

- space + p + i
- esc
- :source%
- :CocInstall
- :call mkdp#util#install()

That's it, now it should work

---

## Future changes

- [ ] Dude WTF about ES12?; Throw to trash JS snippets and update them to ES12
- [x] Split this into files, my config is getting hard to mantein
- [ ] Improve documentation
- [ ] Add more helpers
- [ ] Create a new config using Lua

---

## Summary

| Color schema          | Icon theme                     |
| --------------------- | ------------------------------ |
| (Using) Default       | vim-airline/vim-airline-themes |
| morhetz/gruvbox       | vim-airline/vim-airline        |
| kamykn/dark-theme.vim | ryanoasis/vim-devicons         |

| Motion                         | Identantion and syntax     | Utilities                    | Autocomplete                  |
| ------------------------------ | -------------------------- | ---------------------------- | ----------------------------- |
| christoomey/vim-tmux-navigator | leafgarland/typescript-vim | iamcco/markdown-preview.nvim | editorconfig/editorconfig-vim |
| severin-lemaignan/vim-minimap  | maxmellon/vim-jsx-pretty   | terryma/vim-multiple-cursors | wakatime/vim-wakatime         |
| easymotion/vim-easymotion      | pangloss/vim-javascript    | preservim/nerdcommenter      | jiangmiao/auto-pairs          |
| haya14busa/incsearch.vim       | sheerun/vim-polyglot       | KabbAmine/vCoolor.vim        | tpope/vim-surround            |
| scrooloose/nerdtree            | kovetskiy/sxhkd-vim        | turbio/bracey.vim            | alvan/vim-closetag            |
| junegunn/fzf.vim               | jparise/vim-graphql        | mhinz/vim-signify            | sirver/ultisnips              |
| mileszs/ack.vim                | Yggdroot/indentLine        | ap/vim-css-color             |                               |
|                                | rust-lang/rust.vim         | tpope/vim-repeat             |                               |
|                                | tpope/vim-fugitive         |                              |                               |
|                                | neoclide/coc.nvim          |                              |                               |
|                                | z0mbix/vim-shfmt           |                              |                               |
|                                | jalvesaq/Nvim-R            |                              |                               |

## Apps

There's a couple of apps I recommend you to improve a little bit more your velocity, they are:

- [rofi](https://github.com/davatorium/rofi)
- [Ulauncher](https://ulauncher.io/)
- [Zeal](https://zealdocs.org/)
- [Vimium](https://addons.mozilla.org/es/firefox/addon/vimium-ff/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search)
- [Arch Linux](https://github.com/AndresMpa/dotfiles)

## Pats on the back

If you are reading this it means that you want to improve your velocity or you want to make your own things so, if you start by nvim or vim It may by a little bit complicated but just at the beginning them you'll look like a professional "Ninja Dev"
