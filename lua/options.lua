local opt = vim.opt
local g = vim.g

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
opt.updatetime = 250 -- interval for writing swap file to disk, also used by CursorHold

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

opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

opt.complete = "."
g.omni_sql_default_compl_type = "syntax" -- disable dynamic sql completion

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

opt.swapfile = false -- turn off swapfile

-- use fold markers
opt.foldmethod = "marker"
