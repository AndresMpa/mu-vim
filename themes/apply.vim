" Apply an MμVim palette (g:muvim_palette) as highlight groups.
" Palettes live in this directory and in ~/.config/muvim/themes/*.vim
" User files with the same name win. Choice is stored in ~/.config/muvim/active
" so Current, Mini, and VimScript share it.
if exists('g:loaded_muvim_theme')
  finish
endif
let g:loaded_muvim_theme = 1

let s:shipped = expand('<sfile>:p:h')
let s:user_dir = expand('~/.config/muvim')
let s:user_themes = s:user_dir . '/themes'
let s:active = s:user_dir . '/active'

function! s:hi(group, fg, bg, gui) abort
  let cmd = 'highlight ' . a:group
  if a:fg !=# ''
    let cmd .= ' guifg=' . a:fg
  else
    let cmd .= ' guifg=NONE'
  endif
  if a:bg !=# ''
    let cmd .= ' guibg=' . a:bg
  else
    let cmd .= ' guibg=NONE'
  endif
  if a:gui !=# ''
    let cmd .= ' gui=' . a:gui . ' cterm=' . a:gui
  else
    let cmd .= ' gui=NONE cterm=NONE'
  endif
  execute cmd
endfunction

function! s:get(p, key, fallback) abort
  return get(a:p, a:key, a:fallback)
endfunction

function! s:paint(p) abort
  if has('termguicolors')
    set termguicolors
  endif
  set background=dark

  let bg = s:get(a:p, 'bg', '#0F111A')
  let bg_alt = s:get(a:p, 'bg_alt', '#181A23')
  let fg = s:get(a:p, 'fg', '#A6ACCD')
  let dim = s:get(a:p, 'dim', '#4B5263')
  let red = s:get(a:p, 'red', '#F07178')
  let orange = s:get(a:p, 'orange', '#F78C6C')
  let yellow = s:get(a:p, 'yellow', '#FFCB6B')
  let green = s:get(a:p, 'green', '#C3E88D')
  let cyan = s:get(a:p, 'cyan', '#89DDFF')
  let blue = s:get(a:p, 'blue', '#82AAFF')
  let purple = s:get(a:p, 'purple', '#C792EA')
  let accent = s:get(a:p, 'accent', '#84FFFF')

  highlight clear
  if exists('syntax_on')
    syntax reset
  endif

  call s:hi('Normal', fg, bg, '')
  call s:hi('NormalNC', fg, bg, '')
  call s:hi('NormalFloat', fg, bg_alt, '')
  call s:hi('FloatBorder', dim, bg_alt, '')
  call s:hi('Comment', dim, '', 'italic')
  call s:hi('Constant', orange, '', '')
  call s:hi('String', green, '', '')
  call s:hi('Character', green, '', '')
  call s:hi('Number', orange, '', '')
  call s:hi('Boolean', orange, '', '')
  call s:hi('Float', orange, '', '')
  call s:hi('Identifier', cyan, '', '')
  call s:hi('Function', blue, '', 'bold')
  call s:hi('Statement', purple, '', '')
  call s:hi('Conditional', purple, '', '')
  call s:hi('Repeat', purple, '', '')
  call s:hi('Label', yellow, '', '')
  call s:hi('Operator', cyan, '', '')
  call s:hi('Keyword', purple, '', '')
  call s:hi('Exception', red, '', '')
  call s:hi('PreProc', cyan, '', '')
  call s:hi('Include', cyan, '', '')
  call s:hi('Define', purple, '', '')
  call s:hi('Macro', purple, '', '')
  call s:hi('Type', yellow, '', '')
  call s:hi('StorageClass', yellow, '', '')
  call s:hi('Structure', yellow, '', '')
  call s:hi('Special', accent, '', '')
  call s:hi('SpecialChar', orange, '', '')
  call s:hi('Tag', red, '', '')
  call s:hi('Delimiter', fg, '', '')
  call s:hi('Underlined', blue, '', 'underline')
  call s:hi('Ignore', dim, '', '')
  call s:hi('Error', red, '', 'bold')
  call s:hi('Todo', yellow, '', 'bold')
  call s:hi('ColorColumn', '', bg_alt, '')
  call s:hi('CursorLine', '', bg_alt, '')
  call s:hi('CursorLineNr', accent, bg_alt, 'bold')
  call s:hi('LineNr', dim, bg, '')
  call s:hi('SignColumn', fg, bg, '')
  call s:hi('Folded', dim, bg_alt, 'italic')
  call s:hi('FoldColumn', dim, bg, '')
  call s:hi('MatchParen', accent, bg_alt, 'bold')
  call s:hi('Search', bg, yellow, '')
  call s:hi('IncSearch', bg, orange, '')
  call s:hi('CurSearch', bg, orange, '')
  call s:hi('Visual', '', bg_alt, '')
  call s:hi('NonText', dim, '', '')
  call s:hi('EndOfBuffer', bg, bg, '')
  call s:hi('Whitespace', dim, '', '')
  call s:hi('SpecialKey', dim, '', '')
  call s:hi('Directory', blue, '', 'bold')
  call s:hi('Title', blue, '', 'bold')
  call s:hi('Question', green, '', '')
  call s:hi('MoreMsg', green, '', '')
  call s:hi('ModeMsg', fg, '', 'bold')
  call s:hi('WarningMsg', yellow, '', '')
  call s:hi('ErrorMsg', red, '', 'bold')
  call s:hi('WildMenu', bg, blue, '')
  call s:hi('Pmenu', fg, bg_alt, '')
  call s:hi('PmenuSel', bg, blue, '')
  call s:hi('PmenuSbar', '', bg_alt, '')
  call s:hi('PmenuThumb', '', dim, '')
  call s:hi('StatusLine', fg, bg_alt, '')
  call s:hi('StatusLineNC', dim, bg_alt, '')
  call s:hi('WinSeparator', dim, bg, '')
  call s:hi('VertSplit', dim, bg, '')
  call s:hi('TabLine', dim, bg_alt, '')
  call s:hi('TabLineFill', dim, bg, '')
  call s:hi('TabLineSel', fg, bg, 'bold')
  call s:hi('QuickFixLine', '', bg_alt, '')
  call s:hi('SpellBad', red, '', 'undercurl')
  call s:hi('SpellCap', yellow, '', 'undercurl')
  call s:hi('SpellRare', purple, '', 'undercurl')
  call s:hi('SpellLocal', cyan, '', 'undercurl')
  call s:hi('DiffAdd', green, bg_alt, '')
  call s:hi('DiffChange', yellow, bg_alt, '')
  call s:hi('DiffDelete', red, bg_alt, '')
  call s:hi('DiffText', blue, bg_alt, 'bold')
  call s:hi('DiagnosticError', red, '', '')
  call s:hi('DiagnosticWarn', yellow, '', '')
  call s:hi('DiagnosticInfo', blue, '', '')
  call s:hi('DiagnosticHint', cyan, '', '')
  call s:hi('GitSignsAdd', green, '', '')
  call s:hi('GitSignsChange', yellow, '', '')
  call s:hi('GitSignsDelete', red, '', '')
  call s:hi('TelescopeBorder', dim, bg, '')
  call s:hi('TelescopeSelection', fg, bg_alt, '')
  call s:hi('NvimTreeNormal', fg, bg, '')
  call s:hi('NvimTreeFolderName', blue, '', '')
  call s:hi('NvimTreeOpenedFolderName', blue, '', 'bold')
  call s:hi('NvimTreeEmptyFolderName', dim, '', '')
  call s:hi('NvimTreeFolderIcon', blue, '', '')
  call s:hi('NvimTreeIndentMarker', dim, '', '')
  call s:hi('NvimTreeSymlink', cyan, '', '')
  call s:hi('NvimTreeExecFile', green, '', '')
  call s:hi('NvimTreeImageFile', purple, '', '')
  call s:hi('NvimTreeGitDirty', yellow, '', '')
  call s:hi('NvimTreeGitNew', green, '', '')
  call s:hi('NvimTreeGitDeleted', red, '', '')
  call s:hi('NERDTreeDir', blue, '', '')
  call s:hi('NERDTreeDirSlash', dim, '', '')
  call s:hi('NERDTreeOpenable', blue, '', '')
  call s:hi('NERDTreeClosable', blue, '', '')
  call s:hi('NERDTreeFile', fg, '', '')
  call s:hi('NERDTreeExecFile', green, '', '')
  call s:hi('NERDTreeLinkFile', cyan, '', '')
  call s:hi('NERDTreeCWD', accent, '', 'bold')
  call s:hi('NERDTreeFlags', orange, '', '')
  call s:hi('WebDevIconsDefaultFolderSymbol', blue, '', '')
  call s:hi('WebDevIconsDefaultFileSymbol', fg, '', '')
  call s:hi('StartifyHeader', blue, '', '')
  call s:hi('StartifySection', purple, '', 'bold')
  call s:hi('StartifyPath', dim, '', '')
  call s:hi('StartifyFile', fg, '', '')
  call s:hi('StartifyBracket', dim, '', '')
  call s:hi('StartifyNumber', orange, '', '')
  call s:hi('StartifySelect', green, '', '')
  call s:hi('AlphaHeader', blue, '', '')
  call s:hi('AlphaButtons', fg, '', '')
  call s:hi('AlphaShortcut', orange, '', '')
  call s:hi('CocErrorSign', red, '', '')
  call s:hi('CocWarningSign', yellow, '', '')
  call s:hi('CocInfoSign', blue, '', '')
  call s:hi('CocHintSign', cyan, '', '')

  highlight! link @comment Comment
  highlight! link @string String
  highlight! link @function Function
  highlight! link @keyword Keyword
  highlight! link @type Type
  highlight! link @constant Constant
  highlight! link @variable Identifier
  highlight! link @property Identifier
  highlight! link @punctuation Delimiter

  let g:terminal_color_0 = bg
  let g:terminal_color_1 = red
  let g:terminal_color_2 = green
  let g:terminal_color_3 = yellow
  let g:terminal_color_4 = blue
  let g:terminal_color_5 = purple
  let g:terminal_color_6 = cyan
  let g:terminal_color_7 = fg
  let g:terminal_color_8 = dim
  let g:terminal_color_9 = red
  let g:terminal_color_10 = green
  let g:terminal_color_11 = yellow
  let g:terminal_color_12 = blue
  let g:terminal_color_13 = purple
  let g:terminal_color_14 = accent
  let g:terminal_color_15 = fg

  call s:paint_icons(a:p, red, orange, yellow, green, cyan, blue, purple, accent, fg)
  call s:airline(a:p, bg, bg_alt, fg, dim, red, yellow, green, blue, purple)
  call s:refresh_lualine()
endfunction

function! s:paint_icons(p, red, orange, yellow, green, cyan, blue, purple, accent, fg) abort
  let by_ext = {
        \ 'js': a:yellow, 'mjs': a:yellow, 'cjs': a:yellow, 'jsx': a:cyan,
        \ 'ts': a:blue, 'tsx': a:blue,
        \ 'vue': a:green, 'svelte': a:orange,
        \ 'html': a:orange, 'htm': a:orange,
        \ 'css': a:purple, 'scss': a:purple, 'sass': a:purple, 'less': a:purple,
        \ 'json': a:yellow, 'jsonc': a:yellow,
        \ 'lua': a:blue, 'vim': a:green, 'vimrc': a:green,
        \ 'py': a:yellow, 'rb': a:red, 'go': a:cyan, 'rs': a:orange,
        \ 'c': a:blue, 'h': a:blue, 'cpp': a:blue, 'hpp': a:blue,
        \ 'java': a:orange, 'kt': a:purple,
        \ 'md': a:fg, 'markdown': a:fg,
        \ 'yml': a:red, 'yaml': a:red, 'toml': a:orange, 'xml': a:orange,
        \ 'sh': a:green, 'bash': a:green, 'zsh': a:green, 'fish': a:green,
        \ 'git': a:red, 'gitignore': a:red, 'gitattributes': a:red,
        \ 'dockerfile': a:cyan, 'docker': a:cyan, 'lock': a:fg,
        \ 'svg': a:accent, 'png': a:purple, 'jpg': a:purple, 'jpeg': a:purple,
        \ 'gif': a:purple, 'webp': a:purple,
        \ 'txt': a:fg, 'default': a:fg,
        \ }
  for [ext, color] in items(by_ext)
    let name = toupper(ext[0]) . ext[1:]
    call s:hi('DevIcon' . name, color, '', '')
  endfor
  call s:hi('DevIconDefault', a:fg, '', '')
  call s:hi('GlyphPalette1', a:red, '', '')
  call s:hi('GlyphPalette2', a:green, '', '')
  call s:hi('GlyphPalette3', a:yellow, '', '')
  call s:hi('GlyphPalette4', a:blue, '', '')
  call s:hi('GlyphPalette5', a:purple, '', '')
  call s:hi('GlyphPalette6', a:cyan, '', '')
  call s:hi('GlyphPalette7', a:fg, '', '')
  call s:hi('GlyphPalette9', a:orange, '', '')

  if has('nvim')
    lua << EOF
    local ok, devicons = pcall(require, "nvim-web-devicons")
    local p = vim.g.muvim_palette
    if ok and type(p) == "table" then
      local map = {
        js = p.yellow, mjs = p.yellow, cjs = p.yellow, jsx = p.cyan,
        javascript = p.yellow, typescript = p.blue, ts = p.blue, tsx = p.blue,
        vue = p.green, svelte = p.orange,
        html = p.orange, htm = p.orange,
        css = p.purple, scss = p.purple, sass = p.purple, less = p.purple,
        json = p.yellow, jsonc = p.yellow,
        lua = p.blue, vim = p.green,
        py = p.yellow, python = p.yellow, rb = p.red, ruby = p.red,
        go = p.cyan, rs = p.orange, rust = p.orange,
        c = p.blue, h = p.blue, cpp = p.blue, hpp = p.blue,
        java = p.orange, kt = p.purple,
        md = p.fg, markdown = p.fg,
        yml = p.red, yaml = p.red, toml = p.orange, xml = p.orange,
        sh = p.green, bash = p.green, zsh = p.green, fish = p.green,
        git = p.red, gitignore = p.red, gitattributes = p.red,
        dockerfile = p.cyan, docker = p.cyan, lock = p.dim or p.fg,
        svg = p.accent, png = p.purple, jpg = p.purple, jpeg = p.purple,
        gif = p.purple, webp = p.purple, txt = p.fg, default = p.fg,
      }
      local wheel = { p.red, p.orange, p.yellow, p.green, p.cyan, p.blue, p.purple, p.accent }
      local function color_for(key, spec)
        local k = string.lower(key or "")
        local n = string.lower((spec and (spec.name or spec.cterm_color)) or "")
        if map[k] then return map[k] end
        if map[n] then return map[n] end
        local sum = 0
        for i = 1, #k do
          sum = sum + k:byte(i)
        end
        return wheel[(sum % #wheel) + 1]
      end
      local icons = devicons.get_icons()
      if icons then
        local overrides = {}
        for key, spec in pairs(icons) do
          if type(spec) == "table" then
            overrides[key] = {
              icon = spec.icon,
              color = color_for(key, spec),
              cterm_color = spec.cterm_color,
              name = spec.name,
            }
          end
        end
        devicons.set_icon(overrides)
        pcall(devicons.set_up_highlights)
      end
    end
    if package.loaded["setUp.buffer"] then
      package.loaded["setUp.buffer"] = nil
      pcall(require, "setUp.buffer")
    end
EOF
  endif
endfunction

function! s:airline(p, bg, bg_alt, fg, dim, red, yellow, green, blue, purple) abort
  if !exists('*airline#themes#generate_color_map')
    return
  endif
  let g:airline#themes#muvim#palette = {}
  let n1 = [a:bg, a:blue, 0, 0]
  let n2 = [a:fg, a:bg_alt, 0, 0]
  let n3 = [a:fg, a:bg, 0, 0]
  let g:airline#themes#muvim#palette.normal = airline#themes#generate_color_map(n1, n2, n3)
  let i1 = [a:bg, a:green, 0, 0]
  let g:airline#themes#muvim#palette.insert = airline#themes#generate_color_map(i1, n2, n3)
  let v1 = [a:bg, a:purple, 0, 0]
  let g:airline#themes#muvim#palette.visual = airline#themes#generate_color_map(v1, n2, n3)
  let r1 = [a:bg, a:red, 0, 0]
  let g:airline#themes#muvim#palette.replace = airline#themes#generate_color_map(r1, n2, n3)
  let ia1 = [a:dim, a:bg_alt, 0, 0]
  let g:airline#themes#muvim#palette.inactive = airline#themes#generate_color_map(ia1, ia1, ia1)
  let g:airline_theme = 'muvim'
  silent! AirlineRefresh
endfunction

function! s:refresh_lualine() abort
  if !has('nvim')
    return
  endif
  lua << EOF
  if package.loaded["setUp.statusLine"] then
    package.loaded["setUp.statusLine"] = nil
    pcall(require, "setUp.statusLine")
  end
EOF
endfunction

function! s:theme_file(name) abort
  let user = s:user_themes . '/' . a:name . '.vim'
  if filereadable(user)
    return user
  endif
  let shipped = s:shipped . '/' . a:name . '.vim'
  if filereadable(shipped)
    return shipped
  endif
  return ''
endfunction

function! MuvimThemeNames() abort
  let names = {}
  for dir in [s:shipped, s:user_themes]
    for f in glob(dir . '/*.vim', 0, 1)
      let n = fnamemodify(f, ':t:r')
      if n !=# 'apply'
        let names[n] = 1
      endif
    endfor
  endfor
  return sort(keys(names))
endfunction

function! MuvimThemeComplete(A, L, P) abort
  return join(MuvimThemeNames() + ['none'], "\n")
endfunction

function! s:persist(name) abort
  if !isdirectory(s:user_themes)
    call mkdir(s:user_themes, 'p')
  endif
  if a:name ==# ''
    if filereadable(s:active)
      call delete(s:active)
    endif
    return
  endif
  call writefile([a:name], s:active)
endfunction

function! s:default_name() abort
  return get(g:, 'muvim_default_theme', 'deep-ocean')
endfunction

function! s:load(name, quiet) abort
  let file = s:theme_file(a:name)
  if file ==# ''
    if !a:quiet
      echoerr 'Unknown MμVim theme: ' . a:name
    endif
    return 0
  endif
  let g:muvim_palette = {}
  execute 'source' fnameescape(file)
  if empty(get(g:, 'muvim_palette', {}))
    if !a:quiet
      echoerr 'Theme ' . a:name . ' did not set g:muvim_palette'
    endif
    return 0
  endif
  call s:paint(g:muvim_palette)
  let g:colors_name = a:name
  return 1
endfunction

function! MuvimApplyTheme(name, ...) abort
  let quiet = a:0 && a:1
  if a:name ==# ''
    call MuvimThemePicker()
    return
  endif
  if a:name ==# 'none'
    if s:load(s:default_name(), quiet)
      call s:persist('')
      if !quiet
        echo 'MμVim theme: ' . s:default_name() . ' (default)'
      endif
    endif
    return
  endif
  if s:load(a:name, quiet)
    call s:persist(a:name)
    if !quiet
      echo 'MμVim theme: ' . a:name
    endif
  endif
endfunction

function! MuvimCycleTheme() abort
  call MuvimThemePicker()
endfunction

let s:picker = {}

function! s:picker_saved_name() abort
  if filereadable(s:active)
    let lines = readfile(s:active, '', 1)
    if !empty(lines)
      let name = substitute(lines[0], '^\s*\|\s*$', '', 'g')
      if name !=# ''
        return name
      endif
    endif
  endif
  return s:default_name()
endfunction

function! s:picker_restyle() abort
  if !has('nvim')
    return
  endif
  let win = get(s:picker, 'win', 0)
  if win && nvim_win_is_valid(win)
    call nvim_set_option_value('winhighlight',
          \ 'Normal:Pmenu,CursorLine:PmenuSel,FloatBorder:FloatBorder',
          \ {'win': win})
    call nvim_set_option_value('cursorline', v:true, {'win': win})
  endif
endfunction

function! s:picker_line_name() abort
  return substitute(getline('.'), '^[ *]*', '', '')
endfunction

function! s:picker_preview() abort
  if get(s:picker, 'closing', 0)
    return
  endif
  let name = s:picker_line_name()
  if name ==# '' || name ==# get(s:picker, 'preview', '')
    return
  endif
  let s:picker.preview = name
  call s:load(name, 1)
  call s:picker_restyle()
endfunction

function! s:picker_mouse() abort
  if get(s:picker, 'closing', 0) || !exists('*getmousepos')
    return
  endif
  let m = getmousepos()
  if m.winid != get(s:picker, 'win', 0) || m.line < 1
    return
  endif
  if line('.') != m.line
    noautocmd call cursor(m.line, 1)
  endif
  call s:picker_preview()
endfunction

function! s:picker_finish(save) abort
  if get(s:picker, 'closing', 0)
    return
  endif
  let s:picker.closing = 1
  let name = get(s:picker, 'preview', '')
  let saved = get(s:picker, 'saved', s:default_name())
  if exists('+mousemoveevent') && has_key(s:picker, 'old_move')
    let &mousemoveevent = s:picker.old_move
  endif
  if has('nvim') && get(s:picker, 'win', 0) && nvim_win_is_valid(s:picker.win)
    call nvim_win_close(s:picker.win, v:true)
  endif
  if a:save && name !=# ''
    call s:persist(name)
    echo 'MμVim theme: ' . name
  else
    call s:load(saved, 1)
  endif
  let s:picker = {}
endfunction

function! s:picker_confirm() abort
  call s:picker_preview()
  call s:picker_finish(1)
endfunction

function! s:picker_cancel() abort
  call s:picker_finish(0)
endfunction

function! s:picker_nvim(names, current) abort
  let lines = []
  let start = 1
  let i = 0
  for n in a:names
    let i += 1
    if n ==# a:current
      call add(lines, '* ' . n)
      let start = i
    else
      call add(lines, '  ' . n)
    endif
  endfor
  let buf = nvim_create_buf(v:false, v:true)
  call nvim_buf_set_lines(buf, 0, -1, v:false, lines)
  call nvim_buf_set_option(buf, 'modifiable', v:false)
  call nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  let width = 28
  for n in a:names
    let width = max([width, strdisplaywidth(n) + 4])
  endfor
  let width = min([width, &columns - 4])
  let height = min([len(lines), max([8, &lines / 2])])
  let opts = {
        \ 'relative': 'editor',
        \ 'width': width,
        \ 'height': height,
        \ 'row': max([0, (&lines - height) / 2]),
        \ 'col': max([0, (&columns - width) / 2]),
        \ 'style': 'minimal',
        \ 'border': 'rounded',
        \ }
  try
    let opts.title = ' Themes '
    let opts.title_pos = 'center'
  catch
  endtry
  let win = nvim_open_win(buf, v:true, opts)
  let s:picker.buf = buf
  let s:picker.win = win
  call nvim_win_set_cursor(win, [start, 0])
  setlocal cursorline nowrap nonumber norelativenumber signcolumn=no
  nnoremap <buffer> <silent> <CR> :call <SID>picker_confirm()<CR>
  nnoremap <buffer> <silent> <Esc> :call <SID>picker_cancel()<CR>
  nnoremap <buffer> <silent> q :call <SID>picker_cancel()<CR>
  nnoremap <buffer> <silent> <C-c> :call <SID>picker_cancel()<CR>
  augroup MuvimThemePicker
    autocmd! * <buffer>
    autocmd CursorMoved <buffer> call s:picker_preview()
  augroup END
  if exists('+mousemoveevent') && exists('##MouseMove')
    let s:picker.old_move = &mousemoveevent
    set mousemoveevent
    autocmd MuvimThemePicker MouseMove * call s:picker_mouse()
  endif
  call s:picker_restyle()
  call s:picker_preview()
endfunction

function! s:picker_vim_lines() abort
  let lines = []
  let i = 0
  for n in s:picker.names
    if i == s:picker.idx
      call add(lines, '* ' . n)
    else
      call add(lines, '  ' . n)
    endif
    let i += 1
  endfor
  return lines
endfunction

function! s:picker_vim_filter(id, key) abort
  let last = len(s:picker.names) - 1
  if a:key ==# 'j' || a:key ==# "\<Down>"
    let s:picker.idx = min([s:picker.idx + 1, last])
  elseif a:key ==# 'k' || a:key ==# "\<Up>"
    let s:picker.idx = max([s:picker.idx - 1, 0])
  elseif a:key ==# "\<CR>"
    call popup_close(a:id, 1)
    return 1
  elseif a:key ==# "\<Esc>" || a:key ==# 'q' || a:key ==# "\<C-c>"
    call popup_close(a:id, 0)
    return 1
  else
    return 0
  endif
  call popup_settext(a:id, s:picker_vim_lines())
  call win_execute(a:id, 'call cursor(' . (s:picker.idx + 1) . ', 1)')
  let s:picker.preview = s:picker.names[s:picker.idx]
  call s:load(s:picker.preview, 1)
  return 1
endfunction

function! s:picker_vim_done(id, result) abort
  if a:result == 1 && get(s:picker, 'preview', '') !=# ''
    call s:persist(s:picker.preview)
    echo 'MμVim theme: ' . s:picker.preview
  else
    call s:load(get(s:picker, 'saved', s:default_name()), 1)
  endif
  let s:picker = {}
endfunction

function! s:picker_vim(names, current) abort
  let s:picker.names = a:names
  let s:picker.idx = index(a:names, a:current)
  if s:picker.idx < 0
    let s:picker.idx = 0
  endif
  let s:picker.preview = a:names[s:picker.idx]
  let win = popup_create(s:picker_vim_lines(), {
        \ 'title': ' Themes ',
        \ 'pos': 'center',
        \ 'minwidth': 28,
        \ 'maxheight': max([8, &lines / 2]),
        \ 'border': [],
        \ 'padding': [0, 1, 0, 1],
        \ 'filter': function('s:picker_vim_filter'),
        \ 'callback': function('s:picker_vim_done'),
        \ 'cursorline': 1,
        \ 'highlight': 'Pmenu',
        \ })
  let s:picker.win = win
  call win_execute(win, 'call cursor(' . (s:picker.idx + 1) . ', 1)')
  call s:load(s:picker.preview, 1)
endfunction

function! MuvimThemePicker() abort
  let names = MuvimThemeNames()
  if empty(names)
    echo 'No MμVim themes'
    return
  endif
  if get(s:picker, 'win', 0)
    return
  endif
  let s:picker = {
        \ 'saved': s:picker_saved_name(),
        \ 'preview': '',
        \ 'closing': 0,
        \ 'win': 0,
        \ }
  if has('nvim')
    call s:picker_nvim(names, s:picker.saved)
  elseif exists('*popup_create')
    call s:picker_vim(names, s:picker.saved)
  else
    let cur = get(g:, 'colors_name', '')
    let idx = index(names, cur)
    call MuvimApplyTheme(names[(idx + 1) % len(names)])
  endif
endfunction

function! MuvimThemeRestore() abort
  if filereadable(s:active)
    let lines = readfile(s:active, '', 1)
    if !empty(lines)
      let name = substitute(lines[0], '^\s*\|\s*$', '', 'g')
      if name !=# '' && s:load(name, 1)
        return
      endif
    endif
  endif
  call s:load(s:default_name(), 1)
endfunction

command! -nargs=? -complete=custom,MuvimThemeComplete MuvimTheme call MuvimApplyTheme(<q-args>)
nnoremap <silent> <Plug>(MuvimThemePicker) :call MuvimThemePicker()<CR>
nnoremap <silent> <Plug>(MuvimCycleTheme) :call MuvimThemePicker()<CR>

call MuvimThemeRestore()
