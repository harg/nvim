local group = vim.api.nvim_create_augroup("UserAutocmds", { clear = true })

-- disable Linenumbers in Terminals
vim.api.nvim_create_autocmd("TermOpen", {
  group = group,
  callback = function()
    vim.cmd "setlocal nonumber"
    vim.cmd "setlocal statusline=Terminal"
  end,
})
-- set insert mode when focusing on terminal window
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = group,
  pattern = "term://*",
  callback = function()
    vim.cmd "startinsert"
  end,
})
-- show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "BufEnter" }, {
  group = group,
  callback = function()
    if vim.w.auto_cursorline then
      vim.wo.cursorline = true
      vim.w.auto_cursorline = nil
    end
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "BufLeave" }, {
  group = group,
  callback = function()
    if vim.wo.cursorline then
      vim.w.auto_cursorline = true
      vim.wo.cursorline = false
    end
  end,
})

-- WORKAROUND : reapply the working directory when a file is read, so its name in the
-- buffer list is shown relative to cwd
vim.api.nvim_create_autocmd("BufReadPost", {
  group = group,
  callback = function()
    vim.cmd("silent cd " .. vim.fn.fnameescape(vim.fn.getcwd()))
  end,
})
