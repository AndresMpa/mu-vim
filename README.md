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

MμVim is a Neovim and Vim setup with three configs. This repository is **Current**, the Lua core. Mini and VimScript live in their own repos. New features land here first.

## Other configs

### Mini

A single `init.vim`. Useful as a template or on a server. See [mu-vim-mini](https://github.com/AndresMpa/mu-vim-mini). There is a walkthrough at [andresmpa.github.io/mu-vim-page](https://andresmpa.github.io/mu-vim-page/).

### VimScript (LTS)

Modular VimScript for Vim and Neovim. See [mu-vim-vimscript](https://github.com/AndresMpa/mu-vim-vimscript).

### Current (this repo)

Lua, Neovim only. Use this if you want the latest stack. It is also the most involved of the three.

#### Take a look

![nvim_0](./.examples/nvim_0.png)
![nvim 1](./.examples/nvim_1.png)
![nvim_2](./.examples/nvim_2.png)
![nvim_3](./.examples/nvim_3.png)
![nvim_4](./.examples/nvim_4.png)

## Prerequisites

Current needs [Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim) and [Lua](https://www.lua.org/download.html). It does not run on Vim. The installer can pull the rest of the tools.

## Quick Start

You need Git, Lua (`lua` / `lua5.4` / `luajit`), and a package manager:

| OS | Package manager | Default config dir |
| --- | --- | --- |
| Linux Arch / Manjaro | pacman | `~/.config/nvim` |
| Linux Debian / Ubuntu | apt | `~/.config/nvim` |
| Linux Fedora / RHEL | dnf | `~/.config/nvim` |
| macOS | [Homebrew](https://brew.sh) | `~/.config/nvim` |
| Windows | [winget](https://aka.ms/getwinget) | `%LOCALAPPDATA%\nvim` |

### Linux and macOS

```
git clone https://github.com/AndresMpa/mu-vim.git ~/.config/nvim
cd ~/.config/nvim && lua install.lua
nvim
```

On a Mac, install Homebrew first if you do not have it. The installer uses `brew install` and does not need sudo.

### Windows

```
cd %LOCALAPPDATA%
move nvim nvim_old
git clone https://github.com/AndresMpa/mu-vim.git nvim
cd nvim
lua install.lua
nvim
```

winget installs Neovim, Node LTS, pnpm, ripgrep, and fd. If Lua is missing, `winget install DEVCOM.Lua` (or install Lua from lua.org) and rerun `lua install.lua`.

Then open Neovim:

```
nvim
```

The first launch installs plugins with `:Pckr sync` (mason, formatter, and the rest). That is why a brand-new config reports `module 'mason' not found` until sync finishes. When Pckr is done, quit (`:qa`) and open `nvim` again.

To sync by hand later: `<Space> p i` (install) or `<Space> p u` (sync).

## Uninstall

Removes the config, Mason, pckr plugins, nvim cache/state, and the font this installer copied. Does **not** uninstall Neovim or Homebrew/apt packages (node, pnpm, ripgrep, fd).

```
cd ~/.config/nvim
lua delete.lua
```

On Windows, run `lua delete.lua` from `%LOCALAPPDATA%\nvim`.

## Tests

Mapping contract for Current, Mini, and VimScript (Mini and VimScript have no test repos of their own):

```
./tests/run.sh
```

That uses Podman if it is installed, otherwise Docker. With Go on the host: `cd tests && go test -count=1 -parallel 8 .`

### Check Neovim health

```
nvim
:checkhealth
```

`:checkhealth` is the real next step. Windows often needs a C compiler (Visual Studio Build Tools) for Treesitter. Any OS can be missing `fd` or `pnpm` until the installer finishes. There is a troubleshooting guide
[here](https://github.com/AndresMpa/mu-vim/wiki/General-dependencies)

`Space f` formats the buffer. Python uses **black**, JS/TS/JSON/CSS use **biome** (`pnpm add -g @biomejs/biome` under `~/.local/share/pnpm` — a system pnpm prefix is not writable). HTML, Markdown, Vue, and YAML still use Prettier. Shell uses shfmt; Lua uses stylua.

## Star History

If the project is useful, a star on GitHub helps.

<p align="center">
  <a href="https://star-history.com/#AndresMpa/mu-vim&Date">
   <picture>
     <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=AndresMpa/mu-vim&type=Date&theme=dark" />
     <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=AndresMpa/mu-vim&type=Date" />
     <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=AndresMpa/mu-vim&type=Date" />
   </picture>
  </a>
</p>


## Related tools

- [rofi](https://github.com/davatorium/rofi)
- [Ulauncher](https://ulauncher.io/)
- [Zeal](https://zealdocs.org/)
- [Vimium](https://addons.mozilla.org/firefox/addon/vimium-ff/)
- [Arch Linux](https://github.com/AndresMpa/dotfiles)

## Similar projects

If this setup is not a match, these are worth a look:

- [DoomVim](https://github.com/NTBBloodbath/doom-nvim)
- [NvChad](https://github.com/NvChad/NvChad)
- [LunarVim](https://github.com/LunarVim/LunarVim)

<div align="center">
  <p>
    Thanks to @jx11r for documentation.
  </p>
</div>
