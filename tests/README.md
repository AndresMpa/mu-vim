# Mapping tests

Agnostic checks for MμVim key maps. They parse mapping files; they do not start Neovim.

```bash
python3 tests/run.py
python3 tests/run.py /path/to/mu-vim-mini
python3 tests/run.py /path/to/mu-vim-vimscript
python3 tests/run.py --all

# same contract, if you have Lua:
lua tests/run.lua --all
```

`--all` also looks at `../mu-vim-mini` and `../mu-vim-vimscript`. Mini and VimScript do not need their own test repos.

`shared` must exist in every flavor. `current` is Lua-only. `vim-family` is Mini/VimScript (CoC, fzf, `:ls`).
