local function OpenServer(service)
  pass
end

map('n', '<Leader>xd', ":lua OpenServer('django')<CR>", {})
map('n', '<Leader>xv', ":lua OpenServer('vue')<CR>", {})
