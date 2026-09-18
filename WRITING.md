# Docs voice

How MμVim READMEs are written. Mini and VimScript follow this file.

## Shape

1. Logo and badges.
2. One paragraph: what this repo is.
3. Short links to the other two configs. Do not retell their install recipes.
4. Screenshots.
5. Prerequisites in one or two sentences.
6. Quick Start: OS table, **one** clone into the editor config dir, then what to run inside the editor.
7. Uninstall if this repo has a delete script.
8. Optional: tests, health, related tools.

## Voice

- Neutral English.
- Short sentences, joined with "and", "but", "then".
- Name files, commands, and directories.
- One install path. One uninstall path.
- Brand: **MμVim**. This repo is **Current**, **Mini**, or **VimScript**.
- Plugin lists live in source, not in the README.

## Ambiguity

| Don't | Do |
| --- | --- |
| Two clone commands | Clone into `~/.config/nvim` |
| "Default ~/.config" | `~/.config/nvim` |
| `coc-volar` | `@yaegassy/coc-volar` |
| "Lua version" | **Current** |
