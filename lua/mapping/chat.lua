local function codecompanion_toggle()
  local wins = vim.api.nvim_list_wins()
  for _, win in ipairs(wins) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
    if ft == "codecompanion" then
      vim.api.nvim_win_close(win, false)
      return
    end
  end
  vim.cmd("CodeCompanionChat")
end

vim.keymap.set("n", "<leader>l", codecompanion_toggle, { desc = "Toggle CodeCompanion chat" })
vim.keymap.set("v", "<leader>l", ":<C-u>CodeCompanionChat<cr>", { desc = "CodeCompanion chat with selection" })
vim.keymap.set({ "n", "v" }, "<leader>li", "<cmd>CodeCompanion<cr>", { desc = "CodeCompanion inline" })
vim.keymap.set({ "n", "v" }, "<leader>la", "<cmd>CodeCompanionActions<cr>", { desc = "CodeCompanion actions" })
vim.keymap.set("n", "<leader>lb", "<cmd>CodeCompanionChat Add<cr>", { desc = "Add buffer to chat" })
