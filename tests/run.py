#!/usr/bin/env python3
"""Agnostic mapping tests for MμVim. Same contract as run.lua.

    python3 tests/run.py
    python3 tests/run.py /path/to/mu-vim-mini
    python3 tests/run.py /path/to/mu-vim-vimscript
    python3 tests/run.py --all
"""
from __future__ import annotations

import os
import re
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
REPO = HERE.parent

SHARED = [
    ("<leader>w", "save"),
    ("<leader>q", "quit"),
    ("<leader>h", "close buffer"),
    ("<leader>j", "prev buffer"),
    ("<leader>k", "next buffer"),
    ("<leader>H", "close other buffers"),
    ("<leader>vv", "only this window"),
    ("<leader>vj", "split"),
    ("<leader>vk", "vsplit"),
    ("<leader><", "resize grow"),
    ("<leader>>", "resize shrink"),
    ("<leader>R", "substitute"),
    ("<leader>ss", "easymotion"),
    ("<leader>n", "file tree"),
    ("<leader>pi", "plugin install"),
    ("<leader>pc", "plugin clean"),
    ("<leader>pu", "plugin update"),
    ("<leader>gpl", "git pull"),
    ("<leader>gps", "git push"),
    ("<leader>gii", "git init"),
    ("<leader>gsh", "git show"),
    ("<leader>gbl", "git blame"),
    ("<leader>gst", "git status"),
    ("<leader>gc", "git commit"),
    ("<leader>gaa", "git add --all"),
    ("<leader>grv", "git remote"),
    ("<leader>gsw", "git switch"),
    ("<leader>gco", "git checkout"),
    ("<leader>gcb", "git checkout -b"),
    ("<leader>gll", "git pull origin"),
    ("<leader>gpp", "git push origin"),
    ("<leader>ggg", "git prompt"),
    ("<leader>r", "color picker"),
    ("<leader>hh", "keymap help"),
    ("<leader>x", "run/preview file"),
    ("<leader>f", "format"),
    ("<leader>aw", "toggle autosave"),
    ("<c-t>", "terminal"),
    ("u", "redo"),
]

CURRENT = [
    ("<leader>t", "telescope"),
    ("<leader>tf", "telescope fd"),
    ("<leader>tt", "telescope live_grep"),
    ("<leader>ts", "telescope grep_string"),
    ("<leader>mk", "bufferline next"),
    ("<leader>mj", "bufferline prev"),
    ("<leader>gap", "git add patch"),
    ("<leader>gpx", "git push -u"),
    ("j", "half page down"),
    ("k", "half page up"),
    ("<c-j>", "full page down"),
    ("<c-k>", "full page up"),
    ("fd", "delete fold"),
]

VIM_FAMILY = [
    ("<leader>sf", "blines"),
    ("<leader>ff", "ag"),
    ("<leader>ft", "fzf"),
    ("<leader>a", "ack"),
    ("<leader>b", "buffers"),
    ("<leader>l", "list buffers"),
    ("<leader>pd", "plug upgrade"),
    ("<leader>ga", "git add prompt"),
    ("<leader>xd", "django server"),
    ("<leader>xv", "vue server"),
    ("cd", "coc definition"),
    ("ct", "coc type"),
    ("cg", "coc implementation"),
    ("cr", "coc references"),
]


def normalize(lhs: str) -> str:
    lhs = lhs.strip()
    lhs = re.sub(r"<[Ll]eader>", "<leader>", lhs)
    lhs = re.sub(r"<[Cc]-", "<c-", lhs)
    lhs = re.sub(
        r"^<c-([A-Za-z0-9]+)>",
        lambda m: "<c-" + m.group(1).lower() + ">",
        lhs,
    )
    return lhs


def from_lua(text: str, keys: set[str]) -> None:
    for pat in (
        r'map\s*\(\s*"[nv]"\s*,\s*"([^"]+)"',
        r'keymap\.set\s*\(\s*"[nv]"\s*,\s*"([^"]+)"',
        r'keymap\.set\s*\(\s*\{[^}]+\}\s*,\s*"([^"]+)"',
    ):
        for match in re.finditer(pat, text):
            keys.add(normalize(match.group(1)))


def from_vim(text: str, keys: set[str]) -> None:
    for line in text.splitlines():
        if re.match(r"\s*\"", line):
            continue
        match = re.search(r"<[Ll]eader>([^\s:]*)", line)
        if match:
            keys.add(normalize("<leader>" + match.group(1)))
        match = re.search(r"(<[Cc]-[A-Za-z0-9]+>)", line)
        if match:
            keys.add(normalize(match.group(1)))
        if re.search(r"(^|\s)nmap\s+U\s+", line):
            keys.add("U")
        if "<Plug>(coc" in line:
            match = re.search(r"nmap\s+<silent>\s*(\w+)", line)
            if match:
                keys.add(match.group(1))


def detect(root: Path) -> str | None:
    if (root / "lua/mapping/basis.lua").is_file():
        return "current"
    if (root / ".vim/Mapping.vim").is_file() or (root / "init.vim").is_file():
        return "vim"
    return None


def collect(root: Path) -> tuple[str | None, set[str]]:
    flavor = detect(root)
    keys: set[str] = set()
    if flavor == "current":
        mapping = root / "lua/mapping"
        for path in mapping.rglob("*.lua"):
            from_lua(path.read_text(), keys)
    elif flavor == "vim":
        mapping = root / ".vim/Mapping.vim"
        if mapping.is_file():
            from_vim(mapping.read_text(), keys)
        init = root / "init.vim"
        if init.is_file():
            from_vim(init.read_text(), keys)
    return flavor, keys


def present(keys: set[str], key: str) -> bool:
    if key == "u":
        return "U" in keys or "u" in keys
    if key == "j":
        return "J" in keys or "j" in keys
    if key == "k":
        return "K" in keys or "k" in keys
    return key in keys


def check_group(keys: set[str], group: list[tuple[str, str]], label: str) -> bool:
    missing = [f"{key} ({name})" for key, name in group if not present(keys, key)]
    ok = len(group) - len(missing)
    status = "ok" if not missing else "FAIL"
    print(f"  {label:<12} {status}  {ok}/{len(group)}")
    for item in missing:
        print(f"    missing  {item}")
    return not missing


def run_one(root: Path) -> bool:
    flavor, keys = collect(root)
    if not flavor:
        print(f"SKIP  {root}  (no mapping files)")
        return False
    print(f"[{flavor}]  {root}")
    passed = check_group(keys, SHARED, "shared")
    extra = CURRENT if flavor == "current" else VIM_FAMILY
    label = "current" if flavor == "current" else "vim-family"
    return check_group(keys, extra, label) and passed


def main() -> int:
    if len(sys.argv) > 1 and sys.argv[1] == "--all":
        targets = [REPO, REPO.parent / "mu-vim-mini", REPO.parent / "mu-vim-vimscript"]
    elif len(sys.argv) > 1:
        targets = [Path(sys.argv[1]).resolve()]
    else:
        targets = [REPO]

    failed = 0
    for root in targets:
        if not run_one(root):
            failed += 1
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
