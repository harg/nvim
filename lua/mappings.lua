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
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>s=", "<C-w>=", { desc = "Make splits equal size" })
map("n", "<leader>sd", "<cmd>close<CR>", { desc = "Close current split window" })
map("n", "<leader>wd", "<cmd>close<CR>", { desc = "Close current split window" })
map("n", "<leader>s<Up>", ":resize +5<CR>", { silent = true })
map("n", "<leader>s<Down>", ":resize -5<CR>", { silent = true })
map("n", "<leader>s<Left>", ":vertical resize -5<CR>", { silent = true })
map("n", "<leader>s<Right>", ":vertical resize +5<CR>", { silent = true })

map("n", "<leader><tab>n", "<cmd>tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<CR>", { desc = "Close current tab" })
map("n", "<leader><tab><Right>", "<cmd>tabn<CR>", { desc = "Go to next tab" })
map("n", "<leader><tab><Left>", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
map("n", "<leader><tab><Up>", "<cmd>tabfirst<CR>", { desc = "Go to first tab" })
map("n", "<leader><tab><Down>", "<cmd>tablast<CR>", { desc = "Go to last tab" })
map("n", "<leader><tab>f", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close other tabs" })

-- buffers
map("n", "<BS>", "<c-^>", { desc = "Switch to alternate buffer" })

-- Terminal
map("t", "<tab><tab>", "<C-\\><C-n>", { noremap = true, desc = "Switch to Normal mode" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true, desc = "Switch to Normal mode" })
map("n", "<leader>tt", [[:tabnew | terminal<CR><ESC><ESC>:vsplit | terminal<CR>a]], { noremap = true, silent = true })

-- Highlights
map(
  "n",
  "<F10>",
  [[:lua print(vim.inspect(vim.treesitter.get_captures_at_cursor(0)))<CR>]],
  { noremap = true, silent = true }
)

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
