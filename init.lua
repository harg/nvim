-- clipboard
-- opt.clipboard:append("unnamedplus") -- use system clipboard as default register
-- load clipboard extension first

if jit.os == "Windows" then
  -- local _ = require("nvrplug").paste() -- Useful? Require the library at startup to prevent a small delay during the first invocation
  vim.g.clipboard = {
    name = "c0r",
    copy = {
      ["+"] = function(lines, regtype)
        local content = table.concat(lines, "\r\n")
        require("nvrplug").yank(content)
      end,
      ["*"] = function(lines, regtype)
        local content = table.concat(lines, "\r\n")
        require("nvrplug").yank(content)
      end,
    },
    paste = {
      ["+"] = function()
        local content = require("nvrplug").paste()
        content = content:gsub("\r\n", "\n")
        return { vim.split(content, "\n"), "v" }
      end,
      ["*"] = function()
        local content = require("nvrplug").paste()
        content = content:gsub("\r\n", "\n")
        return { vim.split(content, "\n"), "v" }
      end,
    },
    cache_enabled = 0,
  }
end

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

vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- Neovim in english please
pcall(vim.cmd, "language en_US.UTF-8")

-- before lazy: its ColorScheme autocmd must exist when the colorscheme plugin loads
require "autocmds"

-- Don't display deprecation messages
vim.deprecate = function() end

require("lazy").setup({ { import = "plugins" } }, {
  defaults = { lazy = true },
  install = { colorscheme = { "kanagawa-paper" } },
  checker = {
    enabled = false,
    notify = false,
  },
  change_detection = {
    enabled = false,
    notify = false,
  },
  ui = {
    icons = {
      cmd = "",
      config = "",
      event = "",
      ft = "",
      init = "",
      keys = "",
      plugin = "",
      runtime = "",
      require = "",
      source = "",
      start = "",
      task = "",
      lazy = "",
    },
  },
  performance = {
    rtp = {
      -- names of files in $VIMRUNTIME/plugin/
      disabled_plugins = {
        "gzip",
        "matchit",
        "netrwPlugin",
        "rplugin",
        "spellfile",
        "tarPlugin",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

require "gui"
require "options"

vim.schedule(function()
  require "mappings"
end)

vim.api.nvim_create_user_command("Todos", function()
  require("todos").open()
end, {})
