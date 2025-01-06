-- Disable Linenumbers in Terminals
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = "setlocal nonumber",
})

-- Automatically close terminal Buffers when their Process is done
vim.api.nvim_create_autocmd("TermClose", {
  callback = function()
    vim.cmd "bdelete"
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
