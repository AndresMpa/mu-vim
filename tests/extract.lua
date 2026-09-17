-- Pull map lhs values out of Lua or VimScript files. No Neovim required.

local extract = {}

local function exists(path)
  local f = io.open(path, "r")
  if f then
    f:close()
    return true
  end
  return false
end

local function read(path)
  local f = io.open(path, "r")
  if not f then
    return ""
  end
  local data = f:read("*a")
  f:close()
  return data or ""
end

local function list_files(dir)
  local files = {}
  local pipe = io.popen('find "' .. dir .. '" -type f 2>/dev/null')
  if not pipe then
    return files
  end
  for line in pipe:lines() do
    files[#files + 1] = line
  end
  pipe:close()
  return files
end

function extract.normalize(lhs)
  lhs = lhs:gsub("^%s+", ""):gsub("%s+$", "")
  lhs = lhs:gsub("<[Ll]eader>", "<leader>")
  lhs = lhs:gsub("<[Cc]%-", "<c-")
  lhs = lhs:gsub("^<c%-([%w]+)>", function(inner)
    return "<c-" .. inner:lower() .. ">"
  end)
  return lhs
end

local function add(set, lhs)
  if lhs and lhs ~= "" then
    set[extract.normalize(lhs)] = true
  end
end

function extract.from_lua(text, set)
  for lhs in text:gmatch('map%s*%(%s*"[nv]"%s*,%s*"([^"]+)"') do
    add(set, lhs)
  end
  for lhs in text:gmatch('keymap%.set%s*%(%s*"[nv]"%s*,%s*"([^"]+)"') do
    add(set, lhs)
  end
  for lhs in text:gmatch('keymap%.set%s*%(%s*{[^}]+}%s*,%s*"([^"]+)"') do
    add(set, lhs)
  end
end

function extract.from_vim(text, set)
  for line in (text .. "\n"):gmatch("(.-)\n") do
    if not line:match("^%s*\"") then
      local suffix = line:match("<[Ll]eader>([^%s:]*)")
      if suffix then
        add(set, "<leader>" .. suffix)
      end
      local chord = line:match("(<%s*[Cc]%-[%w]+>)")
      if chord then
        add(set, chord)
      end
      if line:match("%f[%w]nmap%s+U%s+") then
        add(set, "U")
      end
      local coc = line:match("<Plug>%(coc%-%w+%)") and line:match("%f[%w]nmap%s+<silent>%s*(%w+)")
      if coc then
        add(set, coc)
      end
    end
  end
end

function extract.detect(root)
  if exists(root .. "/lua/mapping/basis.lua") then
    return "current"
  end
  if exists(root .. "/.vim/Mapping.vim") then
    return "vim"
  end
  if exists(root .. "/init.vim") then
    return "vim"
  end
  return nil
end

function extract.collect(root)
  local flavor = extract.detect(root)
  local set = {}
  if flavor == "current" then
    for _, path in ipairs(list_files(root .. "/lua/mapping")) do
      if path:match("%.lua$") then
        extract.from_lua(read(path), set)
      end
    end
  elseif flavor == "vim" then
    if exists(root .. "/.vim/Mapping.vim") then
      extract.from_vim(read(root .. "/.vim/Mapping.vim"), set)
    end
    if exists(root .. "/init.vim") then
      extract.from_vim(read(root .. "/init.vim"), set)
    end
  end
  return flavor, set
end

return extract
