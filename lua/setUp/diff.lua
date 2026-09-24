local ok, diffview = pcall(require, "diffview")
if not ok then
  return
end

diffview.setup({
  enhanced_diff_hl = true,
})

local hl_ok, hl = pcall(require, "diffview.hl")
if hl_ok then
  hl.setup()
end

pcall(function()
  require("scheme.apply").paint_diff()
end)
