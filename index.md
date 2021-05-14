## My neovim configuration

### Quick start

Step zero, the easiest way to start with this is to download main branch by
clicking the button above, then use:

```
$ cd My-NVIM-configuration
$ ./install.sh
```

Then, follow the instructions an enjoy it

### A longer way to make this

**First step**

It's import to understand that you are making a custom configuration, it
means that you are the person who is going to maintain your configuration
files, whereas other options like downloading someone else configuration
(Like mine) means that you are not going to be part of maintaining process,
unless you modify your "init.vim" or "vimrc" local files; these options are
less stressful some way, but at the same time it doesn't let you options to
improve your editor tool and if you want to use a terminal editor without
this you are losing the best part of it so, let's start with this by the
tutorial vim tutorial

---

#### Vim tutorial and cheatseet

This is for beginners, so you can skip this item if you already know how
to work why vim or neovim, otherwise if you prefer a video tutorial, this
is a free neovim tutorial at [Udemy](https://www.udemy.com/course/vim-aumenta-tu-velocidad-de-desarrollo/)

> Tip:
> vim and neovim take words as objects, when you understand this you will
> go faster

#### Motion

| Action                                               | Command           |
| ---------------------------------------------------- | ----------------- |
| Move up (Add a number to jump # lines, default 1)    | #k or arrow up    |
| Move down (Add a number to jump # lines, default 1)  | #j or arrow down  |
| Move left (Add a number to jump # lines, default 1)  | #l or arrow left  |
| Move right (Add a number to jump # lines, default 1) | #h or arrow right |

#### Writting

| Action  | Command               |
| ------- | --------------------- |
| Insert  | i or a or o or s      |
| Replace | r or R                |
| Visual  | v                     |
| Copy    | y                     |
| Paste   | p or P                |
| Undo    | u                     |
| Delete  | x or #d + space or dd |
| Search  | # + n or /query + n   |

#### Lines

| Action                                             | Command           |
| -------------------------------------------------- | ----------------- |
| Move to the end of a word # tines (Default 1)      | #e                |
| Move forward a number # of words (Default 1)       | #w                |
| Move backward a number # of words (Default 1)      | #b                |
| Move forward a WORD (any non-whitespace characters | W                 |
| Move the end of current line                       | $                 |
| Move to the beginning of the line                  | 0 or vertical bar |
| Move to the first non-blank character of the line  | ^                 |
| Move to # column                                   | # + Vertical bar  |

#### Jumping

| Action                                                | Command                       |
| ----------------------------------------------------- | ----------------------------- |
| Jump to beginning of file                             | gg or 1G                      |
| Jump to end of file                                   | G                             |
| Jump to any # line                                    | #G                            |
| Jump # screen lines in direction (up,down,left,right) | #g + direction {j, k, h, l}   |
| Move # pages up                                       | # + page up or # + ctrl + b   |
| Move # pages dowm                                     | # + page dowm or # + ctrl + f |
| Jump to the top of the screen                         | H                             |
| Jump to the middle of the screen                      | M                             |
| Jump to the bottom of the screen                      | B                             |
| Jump between sentences                                | ( or )                        |
| Jump between paragraph                                | { or }                        |
| Jump between closing brace                            | %                             |

#### Scrolling

| Action             | Command  |
| ------------------ | -------- |
| Scroll 50% up      | ctrl + d |
| Scroll 50% down    | ctrl + u |
| Scroll 100% up     | ctrl + f |
| Scroll 100% down   | ctrl + b |
| Scroll 1 line up   | ctrl + e |
| Scroll 1 line down | ctrl + y |

#### Marks

| Action                                                               | Command |
| -------------------------------------------------------------------- | ------- |
| Set mark x at the current cursor position                            | mx      |
| Jump to the beginning of the line of mark                            | 'x      |
| Jump to the cursor position of mark x                                | `x      |
| Return to the line where the cursor was before the latest jump       | "       |
| Return to the cursor position before the latest jump (undo the jump) | ``      |
| Jump to the last-changed line                                        | '.      |
| Jump to last edited                                                  | g;      |
