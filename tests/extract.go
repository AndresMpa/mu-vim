package tests

import (
	"os"
	"path/filepath"
	"regexp"
	"strings"
)

var (
	reLeader      = regexp.MustCompile(`<[Ll]eader>`)
	reCtrlPrefix  = regexp.MustCompile(`<[Cc]-`)
	reCtrlChord   = regexp.MustCompile(`^<c-([A-Za-z0-9]+)>`)
	reLuaMap      = regexp.MustCompile(`map\s*\(\s*"[nv]"\s*,\s*"([^"]+)"`)
	reLuaKeymap   = regexp.MustCompile(`keymap\.set\s*\(\s*"[nv]"\s*,\s*"([^"]+)"`)
	reLuaKeymapM  = regexp.MustCompile(`keymap\.set\s*\(\s*\{[^}]+\}\s*,\s*"([^"]+)"`)
	reVimLeader   = regexp.MustCompile(`<[Ll]eader>([^\s:]*)`)
	reVimCtrl     = regexp.MustCompile(`(<[Cc]-[A-Za-z0-9]+>)`)
	reVimRedo     = regexp.MustCompile(`(^|\s)nmap\s+U\s+`)
	reVimComment  = regexp.MustCompile(`^\s*"`)
	reVimCoc      = regexp.MustCompile(`nmap\s+<silent>\s*(\w+)`)
)

func normalize(lhs string) string {
	lhs = strings.TrimSpace(lhs)
	lhs = reLeader.ReplaceAllString(lhs, "<leader>")
	lhs = reCtrlPrefix.ReplaceAllString(lhs, "<c-")
	if m := reCtrlChord.FindStringSubmatch(lhs); m != nil {
		return "<c-" + strings.ToLower(m[1]) + ">"
	}
	return lhs
}

func fromLua(text string, keys map[string]struct{}) {
	for _, re := range []*regexp.Regexp{reLuaMap, reLuaKeymap, reLuaKeymapM} {
		for _, m := range re.FindAllStringSubmatch(text, -1) {
			keys[normalize(m[1])] = struct{}{}
		}
	}
}

func fromVim(text string, keys map[string]struct{}) {
	for _, line := range strings.Split(text, "\n") {
		if reVimComment.MatchString(line) {
			continue
		}
		if m := reVimLeader.FindStringSubmatch(line); m != nil {
			keys[normalize("<leader>"+m[1])] = struct{}{}
		}
		if m := reVimCtrl.FindStringSubmatch(line); m != nil {
			keys[normalize(m[1])] = struct{}{}
		}
		if reVimRedo.MatchString(line) {
			keys["U"] = struct{}{}
		}
		if strings.Contains(line, "<Plug>(coc") {
			if m := reVimCoc.FindStringSubmatch(line); m != nil {
				keys[m[1]] = struct{}{}
			}
		}
	}
}

func detect(root string) string {
	if fileExists(filepath.Join(root, "lua", "mapping", "basis.lua")) {
		return "current"
	}
	if fileExists(filepath.Join(root, ".vim", "Mapping.vim")) || fileExists(filepath.Join(root, "init.vim")) {
		return "vim"
	}
	return ""
}

func collect(root string) (string, map[string]struct{}, error) {
	flavor := detect(root)
	keys := map[string]struct{}{}
	switch flavor {
	case "current":
		err := filepath.WalkDir(filepath.Join(root, "lua", "mapping"), func(path string, d os.DirEntry, err error) error {
			if err != nil || d.IsDir() || !strings.HasSuffix(path, ".lua") {
				return err
			}
			b, err := os.ReadFile(path)
			if err != nil {
				return err
			}
			fromLua(string(b), keys)
			return nil
		})
		return flavor, keys, err
	case "vim":
		for _, rel := range []string{filepath.Join(".vim", "Mapping.vim"), "init.vim"} {
			p := filepath.Join(root, rel)
			if !fileExists(p) {
				continue
			}
			b, err := os.ReadFile(p)
			if err != nil {
				return flavor, keys, err
			}
			fromVim(string(b), keys)
		}
		return flavor, keys, nil
	default:
		return flavor, keys, nil
	}
}

func present(keys map[string]struct{}, key string) bool {
	switch key {
	case "u":
		_, a := keys["U"]
		_, b := keys["u"]
		return a || b
	case "j":
		_, a := keys["J"]
		_, b := keys["j"]
		return a || b
	case "k":
		_, a := keys["K"]
		_, b := keys["k"]
		return a || b
	}
	_, ok := keys[key]
	return ok
}

func fileExists(path string) bool {
	st, err := os.Stat(path)
	return err == nil && !st.IsDir()
}
