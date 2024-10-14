local map = vim.keymap.set -- for conciseness

-- copy / paste with system clipboard

map("v", "<C-Insert>", "\"+ygv<Esc>", { desc = "Copy to system clipboard" }) -- copy to system clipboard
map("v", "<C-c>", "\"+ygv<Esc>", { desc = "Copy to system clipboard" }) -- copy to system clipboard

-- map("!", "<S-Insert>", "<C-R>+", { desc = "Paste from system clipboard" }) -- paste from system clipboard
-- map("i", "<C-v>", "<C-R>+", { desc = "Paste from system clipboard" }) -- paste from system clipboard
-- map("i", "<C-v>", [[<Cmd>set paste<CR><C-r>+<Cmd>set nopaste<CR>]])
-- map("i", "<C-v>", "<Esc>v\"+pgv<Esc>a", { desc = "Paste from system clipboard" }) -- paste from system clipboard
map("i", "<C-v>", "<Esc>\"+p", { desc = "Paste from system clipboard" }) -- paste from system clipboard
map("v", "<C-v>", "\"+pgv<Esc>", { desc = "Paste from system clipboard" }) -- paste from system clipboard

map("v", "<C-x>", "\"+x", { desc = "Cut from system clipboard" }) -- cut to system clipboard


-- save...
map("n", "<C-S>", ":update<CR>", { noremap = true, desc = "Save current buffer" }) -- save current buffer
map("v", "<C-S>", "<C-C>:update<CR>", { noremap = true, desc = "Save current buffer" }) -- save current buffer
map("i", "<C-S>", "<Esc>:update<CR>gi", { noremap = true, desc = "Save current buffer" }) -- save current buffer

-- window management
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Terminal
map("t", "<ESC><ESC>", "<C-\\><C-n>", { noremap = true, desc = "Switch to Normal mode" })
