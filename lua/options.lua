-- vim.cmd('language en_US.UTF-8')
-- vim.api.nvim_set_hl(0, "Normal", { fg = "#e0def4", bg = "#232136" })

local opt = vim.opt
local o = vim.o
local g = vim.g

-- opt.shellslash = true
opt.isfname:append { "(", ")" } -- fix filepath containing parenthesis

-- disable nvim intro and search hit bottom message
opt.shortmess:append "sIc"

-- numbers & cursor
opt.number = true
opt.relativenumber = false
opt.cursorline = true
opt.ruler = false

opt.timeoutlen = 600
opt.ttimeoutlen = 10
opt.updatetime = 250 -- interval for writing swap file to disk, also used by gitsigns

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

opt.wrap = false -- no wrap by default
opt.linebreak = true -- wraps text at the end of a word
opt.scrolloff = 4
opt.sidescrolloff = 2

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- gui
opt.showcmd = false -- don't show commands
opt.showmode = false -- don't show mode

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

opt.complete = "."
g.omni_sql_default_compl_type = "syntax" -- disable dynamic sql completion

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- o.shada = "'100,<50,0,:1000,/100,@100,h" -- limit shada file to 100 entries
opt.swapfile = false -- turn off swapfile

-- use forld markers
opt.foldmethod = "marker"

-- Nvim grey palette
-- Light 1 : #EEF1F8
-- Light 2 : #E0E2EA
-- Light 3 : #C4C6CD
-- Light 5 : #9B9EA4
--
-- Dark 1 : #07080d
-- Dark 2 : #14161B
-- Dark 3 : #2C2E33
-- Dark 4 : #4F5258

-- Palette : https://user-images.githubusercontent.com/71196912/206824417-1020fb4f-e181-441f-be6f-a53ca18e8b26.png

-- Default with black and white colorscheme
-- group_styles = {
--   -- ["Statement"] = { fg = "#FCE094", bold = false }, --NvimLightYellow
--   ["Statement"] = { fg = "#BE95ff", bold = false }, --NvimLightYellow
--
--   ["@function"] = { fg = "#FCE094", bold = false }, -- Function definition
--   ["@function.method"] = { fg = "#FCE094", bold = false }, -- Method definition
--   ["@function.builtin"] = { fg = "#BBBDBF", bold = false },
--   ["@function.call"] = { fg = "#BBBDBF", bold = false },
--   ["@function.method.call"] = { fg = "#BBBDBF", bold = false },
--   ["@function.macro"] = { fg = "#bbbdbf", bold = false },
--
--   ["@tag"] = { fg = "#ff7eb6", bold = false },
--   ["@tag.builtin"] = { fg = "#ee5396", bold = false },
--   ["@tag.attribute"] = { fg = "#BBBDBF", bold = false },
--   ["@tag.delimiter"] = { fg = "#9B9EA4", bold = false },
--
--   ["Normal"] = { fg = "#C4C6CD", bg = "#1e1e1e" },
--   ["Comment"] = { fg = "#77797B" },
--   -- ["String"] = { fg = "#bbbdbf" },
--   ["String"] = { fg = "#08bdba" },
--   ["Function"] = { fg = "#bbbdbf" },
--   ["Identifier"] = { fg = "#dddfe1", bold = false },
--   -- ["Special"] = { fg = "#BBBDBF" },
--   ["Special"] = { fg = "#C4C6CD" },
--   ["Question"] = { fg = "#66686A" },
--   ["Directory"] = { fg = "#77797B" },
--
--   ["MoreMsg"] = { fg = "#EEF1F8", bg = "#4F5258" },
--   ["QuickFixLine"] = { fg = "#EEF1F8", bg = "#4F5258" },
--   ["StatusLineNC"] = { fg = "#4F5258", bg = "#2C2E33" },
--   ["NormalFloat"] = { bg = "None" },
--
--   ["Folded"] = { fg = "#4F5258" },
--   ["MatchParen"] = { fg = "#ffffff", bold = false },
--   ["WinSeparator"] = { fg = "#4F5258" },
--
--   ["Search"] = { fg = "#07080d", bg = "#77797B" },
--   ["CurSearch"] = { fg = "#07080d", bg = "#AAACAF" },
--
--   ["DiagnosticUnnecessary"] = { fg = "#BBBDBF" },
-- }
--
-- for group, style in pairs(group_styles) do
--   vim.api.nvim_set_hl(0, group, style)
-- end
