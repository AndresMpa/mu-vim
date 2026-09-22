-- Resolve tsconfig/jsconfig path aliases (@/, ~/, etc.) for gf and friends.

local M = {}

local EXTS = {
  "",
  ".ts",
  ".tsx",
  ".js",
  ".jsx",
  ".mjs",
  ".cjs",
  ".vue",
  ".svelte",
  ".astro",
  ".json",
  "/index.ts",
  "/index.tsx",
  "/index.js",
  "/index.jsx",
  "/index.vue",
}

local function strip_json_noise(text)
  text = text:gsub("/%*.-%*/", "")
  text = text:gsub("//[^\n]*", "")
  text = text:gsub(",%s*([%]|}])", "%1")
  return text
end

local function read_json(path)
  local f = io.open(path, "r")
  if not f then
    return nil
  end
  local raw = f:read("*a")
  f:close()
  if not raw or raw == "" then
    return nil
  end
  local ok, data = pcall(vim.json.decode, strip_json_noise(raw))
  if ok and type(data) == "table" then
    return data
  end
  return nil
end

local function find_config(start)
  local found = vim.fs.find({ "tsconfig.json", "jsconfig.json" }, {
    upward = true,
    path = start,
    type = "file",
  })
  return found[1]
end

local function first_existing(candidates)
  for _, path in ipairs(candidates) do
    if path and path ~= "" and vim.fn.filereadable(path) == 1 then
      return path
    end
    if path and vim.fn.isdirectory(path) == 1 then
      for _, ext in ipairs(EXTS) do
        if ext ~= "" then
          local nested = path .. ext
          if vim.fn.filereadable(nested) == 1 then
            return nested
          end
        end
      end
    end
  end
  return nil
end

local function expand_target(root, base_url, target, rest)
  target = target:gsub("%*", rest)
  if not vim.startswith(target, "/") then
    target = vim.fs.joinpath(root, base_url, target)
  end
  target = vim.fs.normalize(target)

  local candidates = { target }
  for _, ext in ipairs(EXTS) do
    if ext ~= "" then
      table.insert(candidates, target .. ext)
    end
  end
  return first_existing(candidates)
end

function M.resolve(fname)
  if not fname or fname == "" then
    return fname
  end

  fname = fname:gsub("^[\"']", ""):gsub("[\"']$", "")
  if fname == "" then
    return fname
  end

  if vim.startswith(fname, ".") or vim.startswith(fname, "/") then
    return fname
  end

  local buf = vim.api.nvim_buf_get_name(0)
  local start = (buf ~= "" and vim.fs.dirname(buf)) or vim.fn.getcwd()
  local config_path = find_config(start)
  if not config_path then
    return fname
  end

  local root = vim.fs.dirname(config_path)
  local cfg = read_json(config_path)
  if not cfg then
    return fname
  end

  local compiler = cfg.compilerOptions or {}
  local base_url = compiler.baseUrl or "."
  local paths = compiler.paths or {}

  for pattern, targets in pairs(paths) do
    if type(targets) ~= "table" then
      goto continue
    end
    local plain = pattern:gsub("%*", "")
    local rest = nil
    if pattern:find("%*", 1, true) then
      if vim.startswith(fname, plain) then
        rest = fname:sub(#plain + 1)
      end
    elseif fname == pattern then
      rest = ""
    end
    if rest ~= nil then
      for _, target in ipairs(targets) do
        local hit = expand_target(root, base_url, target, rest)
        if hit then
          return hit
        end
      end
    end
    ::continue::
  end

  if compiler.baseUrl then
    local hit = expand_target(root, base_url, fname, "")
    if hit then
      return hit
    end
  end

  return fname
end

function M.includeexpr(fname)
  return M.resolve(fname)
end

function M.setup_buffer()
  vim.opt_local.suffixesadd:append({
    ".ts",
    ".tsx",
    ".d.ts",
    ".js",
    ".jsx",
    ".mjs",
    ".cjs",
    ".vue",
    ".svelte",
    ".astro",
    ".json",
  })
  vim.opt_local.includeexpr = "v:lua.require('lsp.alias').includeexpr(v:fname)"
end

return M
