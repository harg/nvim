-- disable Linenumbers in Terminals
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.cmd "setlocal nonumber"
    vim.cmd "setlocal statusline=Terminal"
  end,
})
-- set insert mode when focusing on terminal window
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "term://*",
  callback = function()
    vim.cmd "startinsert"
  end,
})
-- show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    if vim.w.auto_cursorline then
      vim.wo.cursorline = true
      vim.w.auto_cursorline = nil
    end
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    if vim.wo.cursorline then
      vim.w.auto_cursorline = true
      vim.wo.cursorline = false
    end
  end,
})

-- UGLY WORKAROUND : reapply the working directory on file/buffer enter in order to set relative filepath in buffer list
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*",
  callback = function()
    local initial_cwd = vim.fn.getcwd()
    vim.cmd("silent cd " .. initial_cwd)
  end,
})

----

-- vim.api.nvim_create_autocmd("User", {
--   pattern = "MiniPickStart",
--   callback = function(event)
--       print(event.buf)
--   end,
-- })
