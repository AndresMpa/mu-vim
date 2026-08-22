local M = {}

local function setup_codecompanion()
  require("codecompanion").setup({
    adapters = {
      ollama = function()
        return require("codecompanion.adapters").extend("ollama", {
          name = "ollama",
          schema = {
            model = "qwen2.5-coder:7b",
            temperature = 0.2,
          },
          env = {
            url = "http://127.0.0.1:11434",
          },
        })
      end,
    },

    strategies = {
      chat = {
        adapter = "ollama",
      },
      inline = {
        adapter = "ollama",
      },
    },
  })
end

function M.setup()
  local ok, codecompanion = pcall(require, "codecompanion")

  if not ok then
    vim.notify("codecompanion.nvim not found", vim.log.levels.WARN)
    return
  end

  setup_codecompanion()
end

M.setup()

return M
