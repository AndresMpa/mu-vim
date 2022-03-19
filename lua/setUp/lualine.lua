local colors = {
  bg       = '#0c0e15',
  fg       = '#bbc2cf',
  alt_fg   = '#07090d',


  -- Status
  -- git
  branch   = '#98be65',
  modified = '#a9a1e1',
  removed  = '#ECBE7B',
  added    = '#008080',
  -- file
  filename = '#c678dd',
  -- clues
  error    = '#c05a60',
  warning  = '#ECBE7B',

  -- Modes
  status   = '#081633',
  normal   = '#6483c5',
  insert   = '#98be65',
  visual   = '#c678dd',
  replace  = '#a34d53',

}

local theme = {
  normal = {
    a = { fg = colors.alt_fg, bg = colors.normal },
    b = { fg = colors.fg, bg = colors.status },
    c = { fg = colors.fg, bg = colors.bg },
    z = { fg = colors.alt_fg, bg = colors.normal },
  },
  insert = { a = { fg = colors.alt_fg, bg = colors.insert } },
  visual = { a = { fg = colors.alt_fg, bg = colors.visual } },
  replace = { a = { fg = colors.fg, bg = colors.replace } },
}

local empty = require('lualine.component'):extend()
function empty:draw(default_highlight)
  self.status = ''
  self.applied_separator = ''
  self:apply_highlights(default_highlight)
  self:apply_section_separators()
  return self.status
end

-- Put proper separators and gaps between components in sections
local function process_sections(sections)
  for name, section in pairs(sections) do
    local left = name:sub(9, 10) < 'x'
    for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
      table.insert(section, pos * 2, { empty, color = { fg = colors.fg, bg = colors.bg } })
    end
    for id, comp in ipairs(section) do
      if type(comp) ~= 'table' then
        comp = { comp }
        section[id] = comp
      end
      comp.separator = left and { right = '' } or { left = '' }
    end
  end
  return sections
end

local function search_result()
  if vim.v.hlsearch == 0 then
    return ''
  end
  local last_search = vim.fn.getreg('/')
  if not last_search or last_search == '' then
    return ''
  end
  local searchcount = vim.fn.searchcount { maxcount = 9999 }
  return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
end

local function modified()
  if vim.bo.modified then
    return '[+]'
  elseif vim.bo.modifiable == false or vim.bo.readonly == true then
    return '[-]'
  end
  return ''
end

require('lualine').setup {
  options = {
    theme = theme,
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = process_sections {
    lualine_a = { 'mode' },
    lualine_b = {
      {
        'branch',
        icon = '',
        color = { fg = colors.branch, gui = 'bold' },
      },
      {
        'diff',
        symbols = { added = ' ', modified = '柳', removed = ' ' },
        diff_color = {
          modified = { fg = colors.modified },
          removed = { fg = colors.removed },
          added = { fg = colors.added },
        },
      },
      {
        'diagnostics',
        source = { 'nvim' },
        sections = { 'error' },
        diagnostics_color = { error = { bg = colors.error, fg = colors.alt_fg } },
      },
      {
        'diagnostics',
        source = { 'nvim' },
        sections = { 'warn' },
        diagnostics_color = { warn = { bg = colors.warning, fg = colors.alt_fg } },
      },
      {
        'filename',
        file_status = false,
        color = {
          fg = colors.filename,
        }
      },
      { modified, color = { bg = colors.error } },
      {
        '%w',
        cond = function()
          return vim.wo.previewwindow
        end,
      },
      {
        '%r',
        cond = function()
          return vim.bo.readonly
        end,
      },
      {
        '%q',
        cond = function()
          return vim.bo.buftype == 'quickfix'
        end,
      },
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { search_result, 'filetype' },
    lualine_z = { '%l:%c', '%p%%/%L' },
  },
  inactive_sections = {
    lualine_c = { '%f %y %m' },
    lualine_x = {},
  },
}
