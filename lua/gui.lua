if vim.g.neovide then
  -- mapping
  vim.keymap.set({ "!", "i" }, "<S-Insert>", "<C-R>+", { desc = "Paste from system clipboard" }) -- paste from system clipboard
  vim.keymap.set("v", "<S-Insert>", '"+pgv<Esc>', { desc = "Paste from system clipboard" }) -- paste from system clipboard

  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_refresh_rate = 165
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_cursor_smooth_blink = false
  vim.g.neovide_padding_top = 7
  vim.g.neovide_padding_bottom = 7
  vim.g.neovide_padding_right = 7
  vim.g.neovide_padding_left = 7

  -- fonts
  -- vim.o.guifont = "UnifontExMono:b:h12:#h-none"
  -- vim.o.guifont = "Consolas_Nerd_Font_Mono:h12.4:#e-subpixelantialias:#h-slight"
  --
  vim.o.linespace = 4
  vim.opt.guicursor = {
    "n-v-c:block-Cursor/lCursor", -- Block cursor in normal, visual, and command modes
    "i:ver25-blinkwait500-blinkoff700-blinkon700-Cursor/lCursor", -- Blinking vertical line in insert mode
    "r-cr-o:hor20-Cursor/lCursor", -- Horizontal line cursor in replace, command-line replace, and operator-pending modes
    "a:blinkwait500-blinkoff700-blinkon700", -- Global blinking settings for all modes
  }

  -- Kanagawa Paper palette terminal colors
  vim.g.terminal_color_0 = "#1f1f28" -- black (bg)
  vim.g.terminal_color_1 = "#E46876" -- red
  vim.g.terminal_color_2 = "#9ece6a" -- green
  vim.g.terminal_color_3 = "#e0af68" -- yellow
  vim.g.terminal_color_4 = "#7aa2f7" -- blue
  vim.g.terminal_color_5 = "#bb9af7" -- magenta
  vim.g.terminal_color_6 = "#7dcfff" -- cyan
  vim.g.terminal_color_7 = "#c0caf5" -- white (fg)
  vim.g.terminal_color_8 = "#565f89" -- bright black (bright bg)
  vim.g.terminal_color_9 = "#E46876" -- bright red
  vim.g.terminal_color_10 = "#9ece6a" -- bright green
  vim.g.terminal_color_11 = "#e0af68" -- bright yellow
  vim.g.terminal_color_12 = "#7aa2f7" -- bright blue
  vim.g.terminal_color_13 = "#bb9af7" -- bright magenta
  vim.g.terminal_color_14 = "#7dcfff" -- bright cyan
  vim.g.terminal_color_15 = "#dcd7ba" -- bright white
end

if vim.g.nvy then
  -- vim.opt.guifont = { "Iosevka Comfy Fixed:h11" }
  -- vim.opt.guifont = { "Iosevc0r540:h11" }
  -- vim.opt.guifont = { "Roboto Mono:h11" }
  -- vim.opt.guifont = { "Cascadia Code FR:h10.5" }
  -- vim.opt.guifont = { "Office Code Pro:h11.5" }
  -- vim.opt.guifont = { "NotoMono NFM:h11" }
  vim.opt.guifont = { "Hack:h11" }
  -- vim.opt.guifont = { "Inc0rsolata:h12.5" }
end
