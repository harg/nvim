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

----

-- vim.api.nvim_create_autocmd("User", {
--   pattern = "MiniPickStart",
--   callback = function(event)
--       print(event.buf)
--   end,
-- })
