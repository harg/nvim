local map = vim.keymap.set -- for conciseness

-- copy / paste with system clipboard

map("v", "<C-Insert>", '"+ygv<Esc>', { desc = "Copy to system clipboard" }) -- copy to system clipboard
map("v", "<C-c>", '"+ygv<Esc>', { desc = "Copy to system clipboard" }) -- copy to system clipboard

-- map("!", "<S-Insert>", "<C-R>+", { desc = "Paste from system clipboard" }) -- paste from system clipboard
-- map("i", "<C-v>", "<C-R>+", { desc = "Paste from system clipboard" }) -- paste from system clipboard
-- map("i", "<C-v>", [[<Cmd>set paste<CR><C-r>+<Cmd>set nopaste<CR>]])
-- map("i", "<C-v>", "<Esc>v\"+pgv<Esc>a", { desc = "Paste from system clipboard" }) -- paste from system clipboard
map("i", "<C-v>", '<Esc>"+p', { desc = "Paste from system clipboard" }) -- paste from system clipboard
map("v", "<C-v>", '"+pgv<Esc>', { desc = "Paste from system clipboard" }) -- paste from system clipboard

map("v", "<C-x>", '"+x', { desc = "Cut from system clipboard" }) -- cut to system clipboard

-- save...
map("n", "<C-S>", ":update<CR>", { noremap = true, desc = "Save current buffer" }) -- save current buffer
map("v", "<C-S>", "<C-C>:update<CR>", { noremap = true, desc = "Save current buffer" }) -- save current buffer
map("i", "<C-S>", "<Esc>:update<CR>gi", { noremap = true, desc = "Save current buffer" }) -- save current buffer

-- window management
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
map("n", "<leader>s<Up>", ":resize +5<CR>", { silent = true })
map("n", "<leader>s<Down>", ":resize -5<CR>", { silent = true })
map("n", "<leader>s<Left>", ":vertical resize -5<CR>", { silent = true })
map("n", "<leader>s<Right>", ":vertical resize +5<CR>", { silent = true })

map("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
map("n", "<leader>tl", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
map("n", "<leader>th", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Terminal
map("t", "<ESC><ESC>", "<C-\\><C-n>", { noremap = true, desc = "Switch to Normal mode" })
map("n", "<leader>tt", [[:tabnew | terminal<CR><ESC><ESC>:vsplit | terminal<CR>]], { noremap = true, silent = true })

-- Spell
map("n", "<leader>sp", "<cmd>set spell!<CR>", { desc = "Toogle spell" })
map("n", ")s", "]s", { desc = "Next misspelled word" })
map("n", "(s", "[s", { desc = "Previous misspelled word" })
local function choose_lang()
  local choice = vim.fn.input "Choose spelllang fr/en : "
  -- Process the choice
  if choice == "fr" or choice == "en" then
    vim.opt.spelllang = choice
  else
    print "\nInvalid choice"
  end
end
vim.api.nvim_create_user_command("ChooseLang", choose_lang, {})
map("n", "<leader>sl", "<cmd>ChooseLang<CR>", { desc = "Choose spelllang" })
