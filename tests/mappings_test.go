package tests

import (
	"fmt"
	"os"
	"path/filepath"
	"testing"
)

func TestMappingContract(t *testing.T) {
	t.Parallel()
	for _, tc := range targets() {
		tc := tc
		t.Run(tc.name, func(t *testing.T) {
			t.Parallel()
			if st, err := os.Stat(tc.root); err != nil || !st.IsDir() {
				t.Skipf("config not mounted: %s", tc.root)
			}
			flavor, keys, err := collect(tc.root)
			if err != nil {
				t.Fatal(err)
			}
			if flavor == "" {
				t.Fatalf("no mapping files in %s", tc.root)
			}
			assertGroup(t, keys, shared, "shared")
			if flavor == "current" {
				assertGroup(t, keys, currentOnly, "current")
			} else {
				assertGroup(t, keys, vimFamily, "vim-family")
			}
		})
	}
}

type target struct {
	name string
	root string
}

func targets() []target {
	current := getenv("MUVIM_CURRENT", filepath.Clean(filepath.Join("..")))
	mini := getenv("MUVIM_MINI", filepath.Clean(filepath.Join("..", "..", "mu-vim-mini")))
	vimscript := getenv("MUVIM_VIMSCRIPT", filepath.Clean(filepath.Join("..", "..", "mu-vim-vimscript")))
	return []target{
		{name: "current", root: current},
		{name: "mini", root: mini},
		{name: "vimscript", root: vimscript},
	}
}

func getenv(key, fallback string) string {
	if v := os.Getenv(key); v != "" {
		return v
	}
	return fallback
}

func assertGroup(t *testing.T, keys map[string]struct{}, group []item, label string) {
	t.Helper()
	var missing []string
	for _, it := range group {
		if !present(keys, it.key) {
			missing = append(missing, fmt.Sprintf("%s (%s)", it.key, it.name))
		}
	}
	if len(missing) > 0 {
		t.Fatalf("%s missing %d/%d: %v", label, len(missing), len(group), missing)
	}
}
