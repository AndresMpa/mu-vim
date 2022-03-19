local function HelpMapping()
  echo "Help"
end

map('n', '<Leader>hh', '[[<Cmd>lua require(util.extention)HelpMapping()<CR>]]', {})


