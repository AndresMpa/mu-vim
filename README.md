# My nvim configuration

> Tip #1
> I really like web dev so this configuration is focus on that stuff anyway everything have been well documented so you can take it just a model if you want to make your own config check about ["CoC"](https://github.com/neoclide/coc.nvim) if want to add more languages support

> Tip #2
> You can use my init.vim file in a .vimrc file if you want, almost everything works, but it may be necessary to change or replace a couple of things

## Quick Start

If you don't know to much about vim or nvim just follow the next steps:

```
$ git clone https://github.com/AndresMpa/My-NVIM-configuration.git
$ mv /nvim-configuration nvim
$ mv /nvim ~/.config
$ nvim
```

Now you must being on neovim (or vim) just make the following commands to install the plugins and that stuff (You may need to install [Plug](https://github.com/junegunn/vim-plug))

- space + p + i
- esc
- :source%
- :CocInstall

That's it, now it should work

---

## Summary

| Color schema | Motion             | Code helpers and syntax | Autocomplete |
| ------------ | ------------------ | ----------------------- | ------------ |
| gruvbox      | vim-tmux-navigator | vim-multi-cursor-next   | vim-surround |
| vim-airline  | vim-easymotion     | nerdcommenter           | vim-closetag |
| vim-devicons | incsearch.vim      | vim-polyglot            | vim-snippets |
|              | nerdtree           | vim-fugitive            | vim-ultisnip |
|              | fzf.vim            | vim-signify             | auto-pairs   |
|              |                    | indentLine              |              |
|              |                    | vim-repeat              |              |
|              |                    | coc.vim                 |              |

## Cheat sheet

### Native

| Action                                     | Command            |
| ------------------------------------------ | ------------------ |
| Move down                                  | j or arrow down    |
| Move up                                    | k or arrow up      |
| Move left                                  | l or arrow left    |
| Move right                                 | h or arrow right   |
| Keep the file (Auto save can be activated) | space + w          |
| Quit nvim (or vim)                         | space + q          |
| History                                    | space + h          |
| Split                                      | space + v + j      |
| Vertical split                             | space + v + k      |
| rezice                                     | space + { + or - } |

#### Buffers

> Tip
> Buffers are basically the files that you have opened; when you open a file it "appends" itself to a "queue", you can switch between those file like next, before and remove from this "queue" of opened files using the next commands

| Action                               | Command   |
| ------------------------------------ | --------- |
| Next file                            | space + j |
| Previous file                        | space + k |
| Delete the current file from buffers | space + l |

---

### Plugins (Can be edited)

> Note
> "Plug" is the plugin manager that I use to manage my plugins, it means that if you are using other, you will have to replace the commands in the next table

#### Plugin Manager

| Action  | Repeat each                                  | Command       |
| ------- | -------------------------------------------- | ------------- |
| Install | Each time you add a plugin                   | space + p + i |
| Clean   | Each time you remove a plugin                | space + p + c |
| Update  | At least once a year                         | space + p + u |
| Upgrade | When you remember to do it (I forget it too) | space + p + d |

#### Plugins

| Action                    | Command           |
| ------------------------- | ----------------- |
| Search words in the file  | / or ?            |
| Move to a concrete letter | space + s         |
| Open file folder          | space + n         |
| Toggle file folder        | space + n + t     |
| Open current file folder  | space + n + c     |
| Search files anywhere     | space + f + f     |
| Search files by extention | space + f + t     |
| Git init                  | space + g + i + i |
| Git show                  | space + g + s + h |
| Git commit                | space + g + c     |
| Git status                | space + g + s + t |
| Git add --all             | space + g + a + a |
| Git remote -v             | space + g + r + v |
| Git remote --add          | space + g + r + a |
| Git pull origin dev       | space + g + p + l |
| Git push origin dev       | space + g + p + s |

## Apps

There's a couple of apps I recommend you to improve a little bit more your velocity, they are:

- [rofi](https://github.com/davatorium/rofi)
- [Ulauncher](https://ulauncher.io/)
- [Vimium](https://addons.mozilla.org/es/firefox/addon/vimium-ff/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search)
- [Arch Linux](https://github.com/AndresMpa/dotfiles)

## Pats on the back

If you are reading this it means that you want to improve your velocity or you want to make your own things so, if you start by nvim or vim I may by a little bit complicated but just at the beginning them you'd look like a professional "Ninja Dev"
