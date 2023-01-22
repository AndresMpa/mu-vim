local execute = vim.api.nvim_command
local extentions = {}

extentions.HelpMapping = function()
	local hints = {
		"x -> Execute file",
		"f -> Format file",
		"<C-t> -> Open a terminal",
	}
	for index, hint in ipairs(hints) do
		print(index, hint)
	end
end

extentions.OpenFileServer = function()
	local extention = vim.bo.filetype
	local file = vim.fn.expand("%")
	print("Starting", extention, "file")

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
