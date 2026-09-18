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
  call s:hi('NERDTreeDir', blue, '', '')
  call s:hi('NERDTreeFile', fg, '', '')
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

  call s:airline(a:p, bg, bg_alt, fg, dim, red, yellow, green, blue, purple)
  call s:refresh_lualine()
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
    echo 'Themes: ' . join(MuvimThemeNames(), ', ')
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
  let names = MuvimThemeNames()
  if empty(names)
    echo 'No MμVim themes'
    return
  endif
  let cur = get(g:, 'colors_name', '')
  let idx = index(names, cur)
  let next = names[(idx + 1) % len(names)]
  call MuvimApplyTheme(next)
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
nnoremap <silent> <Plug>(MuvimCycleTheme) :call MuvimCycleTheme()<CR>

call MuvimThemeRestore()
