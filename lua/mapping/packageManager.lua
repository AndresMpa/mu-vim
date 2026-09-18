local map = vim.keymap.set

local function pckr_run(name)
  local pckr = require("pckr")
  if type(pckr[name]) == "function" then
    pckr[name]()
    return
  end
  vim.cmd("Pckr " .. name)
end

map("n", "<Leader>pi", function()
  pckr_run("install")
end, {})
map("n", "<Leader>pc", function()
  pckr_run("clean")
end, {})
map("n", "<Leader>pu", function()
  pckr_run("sync")
end, {})
