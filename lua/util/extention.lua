local execute = vim.api.nvim_command
local extention = vim.bo.filetype
local extentions = {}

extentions.HelpMapping = function()
  local hints = {
    'Current features',
    '\n',
    '\n',
    '# Basics',
    '\n',
    'w -> Write',
    'q -> Quite',
    'h -> Close file',
    'nj -> Previous',
    'k -> Next',
    'nl -> List',
    'b -> Buffers',
    '\n',
    '\n',
    'zf#j creates a fold from the cursor down # lines',
    'zf/string creates a fold from the cursor to string',
    'zj moves the cursor to the next fold',
    'zk moves the cursor to the previous fold',
    'zo opens a fold at the cursor',
    'zO opens all folds at the cursor',
    'zm increases the foldlevel by one',
    'zM closes all open folds',
    'zr decreases the foldlevel by one',
    'zR decreases the foldlevel to zero — all folds will be open',
    'zd deletes the fold at the cursor',
    'zE deletes all folds',
    '[z move to start of open fold',
    ']z move to end of open fold',
    '\n',
    '\n',
   '# File control',
    '\n',
    'vj -> Split horizontally',
    'vk -> Split vertically',
    '< -> Hide prompt',
    '> -> Expand promt',
    '\n',
    '\n',
    '# Motion mappings',
    '\n',
    'ss -> Search by line',
    'sf -> Search by files',
    '<question mark> -> Search by characters',
    'n -> Search with nerdtree',
    'ff -> Search with ag (folders)',
    'fs -> Search with fzf (files)',
    'a -> Search using Ack',
    '\n',
    '\n',
    '# Replace text',
    '\n',
    'R -> Replace a with b',
    '\n',
    '\n',
    '# Git (Inmediate commands)',
    'gpl -> Git pull',
    'gps -> Git push',
    'gii -> Git init',
    'gsh -> Git show',
    'gbl -> Git blame',
    'gst -> Git status',
    'gc -> Git commit',
    'gaa -> Git add',
    'grv -> Git remote',
    '\n',
    '# Git (Writting)',
    '\n',
    'ga  -> Git add',
    'gsw -> Git switch',
    'gco -> Git checkout',
    'gcb -> Git checkout -b',
    'gll -> Git pull',
    'gpp -> Git push',
    'ggg -> Git (General command)',
    '\n',
    '\n',
    '# CoC',
    '\n',
    'cd -> Coc definition',
    'ct -> Coc type',
    'cg -> Coc implementation',
    'cr -> Coc references',
    '\n',
    '# Formatter',
    '\n',
    'f -> Prettier',
    '\n',
    '\n',
    '# Maintenance',
    '\n',
    'pu -> PackerSync',
    'pc -> PackerClean',
    'pi -> Packernstall',
  }
  for index, hint in ipairs(hints) do
    print(index, hint)
  end
end

extentions.OpenFileServer = function()
  print('Starting', extention, 'file')
  local file = vim.fn.expand('%')

  if extention == "md" then
    execute(":MarkdownPreviewToggle")
  end
  if extention == "html" then
    execute(":Bracey")
  end
  if extention == "python" then
     execute("!python %")
  end
  if extention == "javascript" then
    execute("!node %")
  end
  if extention == "sh" then
    execute("!bash %")
  end
  if extention == "lua" then
    execute("!lua %")
  end
  if string.match(file, "vue") then
    execute("npm run start")
  end
  if string.match(file, "jsx") then
    execute("npm run start")
  end
  if string.match(file, "django") then
    execute("!python %")
  end
end

extentions.OpenTerminal = function()
  local file = vim.fn.expand('%')
  if string.match(file, "/usr/bin/zsh") then
    execute("bdelete!")
  else
    execute("set nonu")
    execute("set nornu")
    execute("belowright split")
    execute("resize 10")
    execute("terminal")
  end
end

extentions.TriggerIdentation = function()
  print('Identating', extention, 'file')

  if extention == "sh" then
    execute(":Shfmt")
  else
    execute(":CocCommand prettier.formatFile")
  end
end

return extentions
