local execute = vim.api.nvim_command
local extentions = {}

function OpenPackage()
  local data = io.popen(
    "find $(git rev-parse --git-dir | sed 's/.git$//') -name 'package.json' -not -path '*node_modules/*'",
    "r"
  )
  if data == nil then
    print("Not package.json avalible")
    return
  end

  local options = {}
  local counter = 0

  for line in data:lines() do
    options[counter] = line
    counter = counter + 1
  end

  print(options[0])
end

local serviceActions = {
  markdown = function()
    print("Check your browser")
    execute(":MarkdownPreviewToggle")
  end,
  html = function()
    execute(":Bracey")
  end,
  python = function()
    execute("!python %")
  end,
  javascript = function()
    execute("!node %")
  end,
  typescript = function(extention, file)
    print("Compiling", extention, "file")
    execute("!npx tsc %")

    print("node output " .. string.sub(file, 1, -3) .. "js")
    execute("!node " .. string.sub(file, 1, -3) .. "js")
  end,
  sh = function()
    execute("!bash %")
  end,
  lua = function()
    execute("!lua %")
  end,
  vue = function()
    execute("npm run start")
    --OpenPackage()
  end,
  jsx = function()
    execute("npm run start")
    --OpenPackage()
  end,
  django = function()
    execute("!python %")
  end,
  png = function()
    execute("!xdg-open %")
  end,
  jpg = function()
    execute("!xdg-open %")
  end,
  svg = function()
    execute("!xdg-open %")
  end,
  jpeg = function()
    execute("!xdg-open %")
  end,
  mp4 = function()
    execute("!xdg-open %")
  end,
}
setmetatable(serviceActions, {
  __index = function()
    return "Option not supported"
  end,
})

extentions.HelpMapping = function()
  local hints = {
    "LSP Diagnostic",
    "mt -> Trouble",
    "mm -> Open diagnostic",
    "md -> Disable",
    "ma -> Enable",
    "mj -> Go previous",
    "mk -> Go next",
    "M -> Infom",
    "mf -> Go definition",
    "mr -> Go reference",
    "mD -> Go declaration",
    "mca -> Code action",
    "mi -> Go implementation",
    "<c-m> -> Show help",

    "GIT",
    "gpl -> git pull",
    "gps -> git push",
    "gii -> git init",
    "gsh -> git show",
    "gbl -> git blame",
    "gc -> git commit",
    "gst -> git status",
    "gaa -> git add <CURRENT_FILE>",
    "gap -> git add -p <CURRENT_FILE>",
    "grv -> git remote -v",
    "gsw -> git switch",
    "gco -> git checkout",
    "gcb -> git checkout -b",
    "gll -> git push origin <CURRENT_BRANCH>",
    "gpp -> git pull origin <CURRENT_BRANCH>",

    "CUSTOME",
    "x -> Execute file",
    "f -> Format file",
    "<C-t> -> Open a terminal",
  }
  for index, hint in ipairs(hints) do
    execute("!echo " .. hint)
  end
end

extentions.HandleGitCustomActions = function(action)
  local branch = vim.fn.system("git branch --show-current | tr -d '\n'")

  if action == "pull" then
    execute(":Git pull origin " .. branch)
  end
  if action == "push" then
    execute(":Git push origin " .. branch)
  end
  if action == "push-commit" then
    execute(":Git push --set-upstream origin " .. branch)
  end
end

extentions.OpenFileServer = function()
  local extention = vim.bo.filetype
  local file = vim.fn.expand("%")

  if serviceActions[extention] ~= "Option not supported" then
    serviceActions[extention](extention, file)
  elseif serviceActions[string.sub(file, -3)] ~= "Option not supported" then
    serviceActions[string.sub(file, -3)](extention, file)
  else
    execute("!echo Option not supported")
    execute("!" .. extention .. " %")
  end
end

extentions.OpenTerminal = function()
  local file = vim.fn.expand("%")
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

return extentions
