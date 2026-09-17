# Mapping tests

Go contract checks. They parse Lua and VimScript mapping files; they do not start Neovim. Mini and VimScript are tested from this repo.

```bash
# Podman or Docker (preferred)
./tests/run.sh

# Host, if you have Go
cd tests && go test -count=1 -parallel 8 .
```

`./tests/run.sh` uses Podman when it is on PATH, otherwise Docker. Compose mounts Current, Mini, and VimScript and runs the three suites in parallel.

`shared` must exist in every flavor. `current` is Lua-only. `vim-family` is Mini/VimScript.
