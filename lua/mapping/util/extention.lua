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
    execute("!pnpm exec tsc %")

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
    execute("!pnpm start")
    --OpenPackage()
  end,
  jsx = function()
    execute("!pnpm start")
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
  vim.cmd("Telescope keymaps")
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
  -- Always a new split on the left. Close with Space q, not Ctrl-t.
  vim.cmd("leftabove vsplit term://zsh")
  vim.wo.number = false
  vim.wo.relativenumber = false

  local buf = vim.api.nvim_get_current_buf()
  vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w><C-h>", { buffer = buf, silent = true })
  vim.keymap.set("t", "<C-\\><C-\\>", "<C-\\><C-n>", { buffer = buf, silent = true })
  vim.keymap.set("t", "<Leader>q", "<C-\\><C-n>:q!<CR>", { buffer = buf, silent = true })
  vim.cmd("startinsert!")
end

return extentions
