local ok, diffview = pcall(require, "diffview")
if not ok then
  return
end

-- One panel is the source of truth (focused diff pane). The other only follows.
local saved_lazyredraw = nil
local syncing = false
local leader_win = nil
local augroup = vim.api.nvim_create_augroup("MuvimDiffviewScroll", { clear = true })

local function is_diff_win(win)
  if not win or not vim.api.nvim_win_is_valid(win) then
    return false
  end
  local ok_diff, is_diff = pcall(vim.api.nvim_get_option_value, "diff", { win = win })
  return ok_diff and is_diff
end

local function diff_wins()
  local tab = vim.api.nvim_get_current_tabpage()
  local wins = {}
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
    if is_diff_win(win) then
      wins[#wins + 1] = win
    end
  end
  table.sort(wins)
  return wins
end

-- Prefer focused diff pane; else last leader; else rightmost diff pane.
local function get_leader()
  local cur = vim.api.nvim_get_current_win()
  if is_diff_win(cur) then
    leader_win = cur
    return cur
  end
  if leader_win and is_diff_win(leader_win) then
    return leader_win
  end
  local wins = diff_wins()
  if #wins == 0 then
    return nil
  end
  -- Rightmost = working tree in the default horizontal layout.
  leader_win = wins[#wins]
  return leader_win
end

local function clamp_topline(win, topline)
  local last = vim.api.nvim_buf_line_count(vim.api.nvim_win_get_buf(win))
  local height = vim.api.nvim_win_get_height(win)
  local max_top = math.max(1, last - height + 1)
  return math.max(1, math.min(topline, max_top))
end

local function clamp_cursor(win, lnum, col)
  local buf = vim.api.nvim_win_get_buf(win)
  local last = vim.api.nvim_buf_line_count(buf)
  local row = math.max(1, math.min(lnum, last))
  local line = vim.api.nvim_buf_get_lines(buf, row - 1, row, false)[1] or ""
  local c = math.max(0, math.min(col, #line))
  return row, c
end

-- Push leader location (scroll + cursor) onto every other diff pane.
local function follow_leader(src)
  if syncing then
    return
  end
  src = src or get_leader()
  if not src or not is_diff_win(src) then
    return
  end
  leader_win = src

  local wins = diff_wins()
  if #wins < 2 then
    return
  end

  local view = vim.api.nvim_win_call(src, vim.fn.winsaveview)
  local row, col = unpack(vim.api.nvim_win_get_cursor(src))

  syncing = true
  for _, win in ipairs(wins) do
    if win ~= src then
      pcall(vim.api.nvim_win_call, win, function()
        local r, c = clamp_cursor(win, row, col)
        local top = clamp_topline(win, view.topline)
        local height = vim.api.nvim_win_get_height(0)
        -- Keep cursor inside the mirrored viewport.
        if r < top then
          r = top
        elseif r > top + height - 1 then
          r = top + height - 1
        end
        r, c = clamp_cursor(win, r, c)
        vim.fn.winrestview({
          lnum = r,
          col = c,
          topline = top,
          leftcol = view.leftcol,
          curswant = view.curswant,
          skipcol = view.skipcol or 0,
        })
      end)
    end
  end
  syncing = false
end

-- Wheel only moves the leader; followers copy that location.
local function wheel(delta)
  return function()
    local src = get_leader()
    if not src then
      return
    end
    -- Focus leader so location always originates from one pane.
    if vim.api.nvim_get_current_win() ~= src then
      pcall(vim.api.nvim_set_current_win, src)
    end
    local view = vim.api.nvim_win_call(src, vim.fn.winsaveview)
    local top = clamp_topline(src, view.topline + delta)
    local height = vim.api.nvim_win_get_height(src)
    local lnum = view.lnum
    if lnum < top then
      lnum = top
    elseif lnum > top + height - 1 then
      lnum = top + height - 1
    end
    syncing = true
    pcall(vim.api.nvim_win_call, src, function()
      local cur = vim.fn.winsaveview()
      cur.topline = top
      cur.lnum = lnum
      vim.fn.winrestview(cur)
    end)
    syncing = false
    follow_leader(src)
  end
end

local function on_diff_win()
  vim.opt_local.foldenable = false
  vim.opt_local.foldlevel = 99
  vim.opt_local.scrolloff = 0
  vim.opt_local.sidescrolloff = 0
  -- We own sync from a single leader; native bind fights and desyncs.
  vim.opt_local.scrollbind = false
  vim.opt_local.cursorbind = false
  pcall(function()
    vim.opt_local.cursorlinebind = false
  end)

  local buf = vim.api.nvim_get_current_buf()
  local opts = { buffer = buf, silent = true, nowait = true }
  vim.keymap.set({ "n", "i", "v" }, "<ScrollWheelUp>", wheel(-3), opts)
  vim.keymap.set({ "n", "i", "v" }, "<ScrollWheelDown>", wheel(3), opts)
  vim.keymap.set({ "n", "i", "v" }, "<S-ScrollWheelUp>", wheel(-1), opts)
  vim.keymap.set({ "n", "i", "v" }, "<S-ScrollWheelDown>", wheel(1), opts)

  if is_diff_win(vim.api.nvim_get_current_win()) then
    leader_win = vim.api.nvim_get_current_win()
  end
end

vim.api.nvim_create_autocmd("WinEnter", {
  group = augroup,
  callback = function()
    local cur = vim.api.nvim_get_current_win()
    if is_diff_win(cur) then
      leader_win = cur
      vim.schedule(function()
        follow_leader(cur)
      end)
    end
  end,
})

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  group = augroup,
  callback = function()
    if syncing then
      return
    end
    local cur = vim.api.nvim_get_current_win()
    if is_diff_win(cur) then
      leader_win = cur
      follow_leader(cur)
    end
  end,
})

vim.api.nvim_create_autocmd("WinScrolled", {
  group = augroup,
  callback = function(args)
    if syncing then
      return
    end
    local src = tonumber(args.match)
    local ev = vim.v.event
    if type(ev) == "table" and type(ev.windows) == "table" then
      for _, w in ipairs(ev.windows) do
        if is_diff_win(w) then
          -- Only the leader may drive scroll; ignore follower noise.
          local lead = get_leader()
          if w == lead or not lead then
            src = w
            break
          end
        end
      end
    end
    if src and is_diff_win(src) then
      leader_win = src
      follow_leader(src)
    end
  end,
})

diffview.setup({
  enhanced_diff_hl = true,
  icons = {
    folder_closed = "",
    folder_open = "",
  },
  signs = {
    fold_closed = "",
    fold_open = "",
    done = "",
  },
  hooks = {
    view_enter = function()
      if saved_lazyredraw == nil then
        saved_lazyredraw = vim.o.lazyredraw
      end
      vim.o.lazyredraw = false
    end,
    view_leave = function()
      leader_win = nil
      if saved_lazyredraw ~= nil then
        vim.o.lazyredraw = saved_lazyredraw
        saved_lazyredraw = nil
      end
    end,
    view_opened = function()
      vim.schedule(function()
        for _, win in ipairs(diff_wins()) do
          pcall(vim.api.nvim_win_call, win, on_diff_win)
        end
        follow_leader(get_leader())
      end)
    end,
    diff_buf_win_enter = function()
      on_diff_win()
      follow_leader(get_leader())
    end,
  },
})

local hl_ok, hl = pcall(require, "diffview.hl")
if hl_ok then
  hl.setup()
end

-- Diffview prints raw git letters (M/A/D). Same icon family as greeter / nvim-tree.
do
  local status_icons = {
    A = "", -- added
    ["?"] = "", -- untracked
    M = "", -- modified
    R = "➜", -- renamed
    C = "", -- copied
    T = "", -- type change (branch-style)
    U = "", -- unmerged
    D = "", -- deleted
    B = "", -- broken
    X = "", -- unknown
    ["!"] = "", -- ignored
  }

  local function iconize(text)
    if type(text) ~= "string" then
      return text
    end
    -- "M", "M ", "?" alone on the row edge (files + dirs).
    local letter, rest = text:match("^([A-Za-z?!])([%s]*)$")
    if not letter then
      return text
    end
    local key = letter:match("%a") and letter:upper() or letter
    local icon = status_icons[key]
    if icon then
      return icon .. (rest ~= "" and rest or " ")
    end
    return text
  end

  local ok_r, renderer = pcall(require, "diffview.renderer")
  if ok_r and renderer.RenderComponent and renderer.RenderComponent.add_text then
    local orig = renderer.RenderComponent.add_text
    renderer.RenderComponent.add_text = function(self, text, hl_group)
      if type(hl_group) == "string" and hl_group:match("^DiffviewStatus") then
        text = iconize(text)
      elseif type(text) == "string" and text:match("^[A-Za-z?!]%s*$") and status_icons[text:sub(1, 1):upper()] then
        text = iconize(text)
      end
      return orig(self, text, hl_group)
    end
  end
end

pcall(function()
  require("scheme.apply").paint_diff()
end)
