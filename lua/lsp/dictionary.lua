require("cmp_dictionary").setup({
	dic = {
		--I removing this support for every possibility, I found it annoying
		--["*"] = "~/.config/nvim/dicts/english.dict",
		filepath = {
			["COMMIT_EDITMSG"] = "~/.config/nvim/dicts/english.dict",
			["*%.html"] = "~/.config/nvim/dicts/english.dict",
			["*%.txt"] = "~/.config/nvim/dicts/english.dict",
			["*%.md"] = "~/.config/nvim/dicts/english.dict",
		},
		spelllang = {
			--en = "/path/to/en.dict",
		},
	},
})
