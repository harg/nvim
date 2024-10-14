-- vim.cmd('language en_US.UTF-8')

local opt = vim.opt
local o = vim.o
local g = vim.g

-- opt.shellslash = true
opt.isfname:append({ '(', ')' }) -- fix filepath containing parenthesis

-- disable nvim intro
opt.shortmess:append "sI"

-- numbers
opt.relativenumber = false
opt.number = true
opt.cursorline = true
opt.ruler = false

opt.timeoutlen = 500
opt.ttimeoutlen = 10
opt.updatetime = 250 -- interval for writing swap file to disk, also used by gitsigns

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

opt.wrap = false

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

opt.showcmd = false -- don't show commands
opt.showmode = false -- don't show mode

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
-- opt.clipboard:append("unnamedplus") -- use system clipboard as default register


-- vim.g.clipboard = {
--   name = "clip.exe (Copy Only)",
--   copy = {
--     ["+"] = "clip.exe",
--     ["*"] = "clip.exe"
--   },
--   paste = {
--     ["+"] = "clip.exe",
--     ["*"] = "clip.exe"
--   },
--   cache_enabled = true
-- }

-- vim.g.clipboard = {
--     name = 'win32yank-wsl',
--     copy = {
--         ['+'] =  'win32yank.exe -i --crlf',
--         ['*'] =  'win32yank.exe -i --crlf',
--     },
--     paste = {
--         ['+'] = 'win32yank.exe -o --lf',
--         ['*'] = 'win32yank.exe -o --lf',
--     },
--     cache_enabled = true,
-- }

-- vim.g.clipboard = {
--       name = 'OSC 52',
--       copy = {
--         ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
--         ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
--       },
--       paste = {
--         ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
--         ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
--       },
-- }

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false


-- use forld markers
opt.foldmethod = "marker"

---------------------------------------------------------------

-- clipboard loading
-- local is_wsl = vim.fn.has "wsl"
-- local is_windows = vim.fn.has "win32" or vim.fn.has "win64"
-- local is_mac = vim.fn.has "macunix"
-- local is_unix = vim.fn.has "unix"

-- vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
--   once = true,
--   callback = function()
--     if is_windows == 1 and not is_wsl == 1 then
--       print "Using Windows clipboard."
--       vim.g.clipboard = {
--         copy = {
--           ["+"] = "win32yank.exe -i --crlf",
--           ["*"] = "win32yank.exe -i --crlf",
--         },
--         paste = {
--           ["+"] = "win32yank.exe -o --lf",
--           ["*"] = "win32yank.exe -o --lf",
--         },
--       }
--     elseif is_mac == 1 then
--       vim.g.clipboard = {
--         copy = {
--           ["+"] = "pbcopy",
--           ["*"] = "pbcopy",
--         },
--         paste = {
--           ["+"] = "pbpaste",
--           ["*"] = "pbpaste",
--         },
--       }
--     elseif is_unix == 1 or is_wsl == 1 then
--       if vim.fn.executable "xclip" == 1 then
--         vim.g.clipboard = {
--           copy = {
--             ["+"] = "xclip -selection clipboard",
--             ["*"] = "xclip -selection clipboard",
--           },
--           paste = {
--             ["+"] = "xclip -selection clipboard -o",
--             ["*"] = "xclip -selection clipboard -o",
--           },
--         }
--       elseif vim.fn.executable "xsel" == 1 then
--         vim.g.clipboard = {
--           copy = {
--             ["+"] = "xsel --clipboard --input",
--             ["*"] = "xsel --clipboard --input",
--           },
--           paste = {
--             ["+"] = "xsel --clipboard --output",
--             ["*"] = "xsel --clipboard --output",
--           },
--         }
--       end
--     end
--
--     vim.opt.clipboard = "unnamedplus"
--   end,
--   desc = "Lazy load clipboard",
-- })
