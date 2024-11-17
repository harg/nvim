if vim.g.neovide then
  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_refresh_rate = 165
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_hide_mouse_when_typing = true
  -- vim.o.guifont = "Inc0rsolata:h13.1:W100:#e-subpixelantialias:#h-slight"
  -- vim.o.guifont = "Iosevc0r540-350:h11.3:#e-subpixelantialias:#h-slight"
  vim.o.guifont = "Hack Nerd Font:h12:#e-subpixelantialias:#h-slight"
  vim.o.linespace = 1
end

if vim.g.nvy then
  -- vim.opt.guifont = { "Iosevka Comfy Fixed:h11" }
  -- vim.opt.guifont = { "Iosevc0r540:h11" }
  -- vim.opt.guifont = { "Roboto Mono:h11" }
  -- vim.opt.guifont = { "Cascadia Code FR:h10.5" }
  -- vim.opt.guifont = { "Office Code Pro:h11.5" }
  -- vim.opt.guifont = { "NotoMono NFM:h11" }
  vim.opt.guifont = { "Hack Nerd Font:h11" }
  -- vim.opt.guifont = { "Inc0rsolata:h12.5" }
end
