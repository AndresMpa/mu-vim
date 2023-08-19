local execute = vim.api.nvim_command
local extentions = {}

extentions.HelpMapping = function()
	local branch = vim.fn.system("git branch --show-current | tr -d '\n'")
	print("Current branch: " .. branch)
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
		print(index, hint)
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
end

extentions.OpenFileServer = function()
	local extention = vim.bo.filetype
	local file = vim.fn.expand("%")
	print("Starting", extention, "file")

	if extention == "markdown" then
		print("Check your browser")
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
	if extention == "typescript" then
		print("Compiling", extention, "file")
		execute("!npx tsc %")

		print("node output " .. string.sub(file, 1, -3) .. "js")
		execute("!node " .. string.sub(file, 1, -3) .. "js")
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
	if string.match(file, "png") then
		execute("!xdg-open %")
	end
	if string.match(file, "jpg") then
		execute("!xdg-open %")
	end
	if string.match(file, "svg") then
		execute("!xdg-open %")
	end
	if string.match(file, "jpeg") then
		execute("!xdg-open %")
	end
	if string.match(file, "mp4") then
		execute("!xdg-open %")
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
