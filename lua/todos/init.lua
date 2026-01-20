local M = {}
local state = {
  todos = {},
  current_line = nil,
  todos_win = nil,
  title_win = nil,
  body_win = nil,
  titles_buf = nil,
  body_buf = nil,
}

vim.fn.sign_define("body_sign", {
  text = " ",
  texthl = "DiagnosticHint",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("list_sign", {
  text = " ",
  texthl = "DiagnosticHint",
  linehl = "",
  numhl = "",
})

---Table Helpers
local function table_insert_after(tbl, index, value)
  table.insert(tbl, index + 1, value)
end

local function table_is_empty(tbl)
  return next(tbl) == nil
end

local function table_swap_adjacent(tbl, index, direction)
  -- direction: -1 for previous, 1 for next
  local target = index + direction

  -- Validate indices
  if index < 1 or index > #tbl then
    return
  end
  if target < 1 or target > #tbl then
    return
  end

  -- Perform swap
  tbl[index], tbl[target] = tbl[target], tbl[index]

  return
end

---
--- UI Helpers
local function close_and_focus(win_close, win_focus)
  if vim.api.nvim_win_is_valid(win_close) then
    vim.api.nvim_win_close(win_close, true)
  end

  if vim.api.nvim_win_is_valid(win_focus) then
    vim.api.nvim_set_current_win(win_focus)
  end
end

local function titles_buf_set_lines(i, j, lines)
  -- Update the original line
  vim.api.nvim_set_option_value("modifiable", true, { buf = state.titles_buf })
  vim.api.nvim_buf_set_lines(state.titles_buf, i, j, false, lines)
  vim.api.nvim_set_option_value("modifiable", false, { buf = state.titles_buf })
  vim.api.nvim_set_option_value("modified", false, { buf = state.titles_buf }) -- get rid of [+]
end
---

local function load_todos()
  local path = vim.fn.stdpath "data" .. "/todos/data.json"
  if vim.fn.filereadable(path) == 1 then
    local data = vim.json.decode(table.concat(vim.fn.readfile(path)))
    state.todos = {}
    for i, item in ipairs(data) do
      state.todos[i] = {
        title = item.title,
        body = item.body,
      }
    end
  else -- create file if not exists
    vim.fn.mkdir(vim.fn.stdpath "data" .. "/todos", "p")
    local path = vim.fn.stdpath "data" .. "/todos/data.json"
    vim.fn.writefile({ vim.json.encode {} }, path)
  end
end

local function render_titles()
  local titles = {}
  for _, todo in ipairs(state.todos) do
    table.insert(titles, todo.title)
  end
  vim.api.nvim_buf_set_lines(state.titles_buf, 0, -1, false, titles)
end

local function render_body_signs()
  -- remove all signs
  vim.fn.sign_unplace("*", {
    buffer = state.titles_buf,
  })

  for i, todo in ipairs(state.todos) do
    if table_is_empty(todo.body) == false then
      vim.fn.sign_place(
        0, -- sign ID (0 = auto-assign)
        "TodosBodySign", -- sign group
        "body_sign", -- sign name
        state.titles_buf, -- buffer (0 = current)
        { lnum = i } -- line number
      )
    else
      vim.fn.sign_place(
        0, -- sign ID (0 = auto-assign)
        "TodosListSign", -- sign group
        "list_sign", -- sign name
        state.titles_buf, -- buffer (0 = current)
        { lnum = i } -- line number
      )
    end
  end
end

function M.save_todos()
  -- write state in data.json
  local path = vim.fn.stdpath "data" .. "/todos/data.json"
  vim.fn.writefile({ vim.json.encode(state.todos) }, path)

  print "Todos saved"
end

--- NEW TODO

function M.create_todo()
  -- Get all lines from the float buffer
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

  -- Concatenate multiple lines with space
  local buf_content = table.concat(lines, " ")

  local todo = { title = buf_content, body = {} }

  if table_is_empty(state.todos) then
    -- first todo
    -- update state
    table.insert(state.todos, state.current_line, todo)
    -- update ui
    titles_buf_set_lines(state.current_line - 1, state.current_line, { todo.title })
  else
    -- update state
    table_insert_after(state.todos, state.current_line, todo)
    -- update ui
    titles_buf_set_lines(state.current_line, state.current_line, { todo.title })
    vim.api.nvim_win_set_cursor(state.todos_win, { state.current_line + 1, 0 })
  end

  -- Mark buffer as saved
  vim.bo[buf].modified = false

  vim.schedule(function()
    render_body_signs()
    M.save_todos()
  end)

  close_and_focus(state.title_win, state.todos_win)

  print "Todo Created!"
end

function M.new_todo()
  -- Get current cursor
  local cursor = vim.api.nvim_win_get_cursor(state.todos_win)
  state.current_line = cursor[1]

  -- Create a new buffer
  local buf = vim.api.nvim_create_buf(false, true)
  -- Calculate floating window size and position
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.6)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Create floating window
  state.title_win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = "New todo",
    title_pos = "center",
  })

  -- Set buffer options
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false

  vim.api.nvim_buf_set_keymap(buf, "n", "<esc>", ':lua require("todos").create_todo()<CR>', { noremap = true })
end

--- UPDATE TODO

function M.update_todo()
  -- Get all lines from the float buffer
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

  -- Concatenate multiple lines with space
  local updated_title = table.concat(lines, " ")

  -- update state
  state.todos[state.current_line] = { title = updated_title, body = state.todos[state.current_line].body }
  -- update ui
  titles_buf_set_lines(state.current_line - 1, state.current_line, { updated_title })

  -- Mark buffer as saved
  vim.bo[buf].modified = false

  vim.schedule(function()
    render_body_signs()
    M.save_todos()
  end)

  close_and_focus(state.title_win, state.todos_win)

  print "Todo Updated!"
end

function M.edit_todo()
  if table_is_empty(state.todos) then
    return
  end

  -- Get current cursor

  local cursor = vim.api.nvim_win_get_cursor(state.todos_win)
  state.current_line = cursor[1]

  -- Get current line content
  local line_content = vim.api.nvim_buf_get_lines(state.titles_buf, state.current_line - 1, state.current_line, false)[1]

  -- Create a new buffer for editing
  local buf = vim.api.nvim_create_buf(false, true)

  -- Set buffer content
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { line_content })

  -- Calculate floating window size and position
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.6)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Create floating window
  state.title_win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = " Edit Todo - " .. line_content,
    title_pos = "center",
  })

  -- Set buffer options
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false

  vim.api.nvim_buf_set_keymap(buf, "n", "<esc>", ':lua require("todos").update_todo()<CR>', { noremap = true })
end

--- DELETE TODO ---

function M.delete_todo()
  if table_is_empty(state.todos) then
    return
  end

  -- Get current cursor
  local cursor = vim.api.nvim_win_get_cursor(state.todos_win)
  state.current_line = cursor[1]

  -- update state
  table.remove(state.todos, state.current_line)
  -- update ui
  titles_buf_set_lines(state.current_line - 1, state.current_line, {})

  vim.schedule(function()
    render_body_signs()
    M.save_todos()
  end)

  print "Todo Deleted!"
end

--- EDIT BODY ---

function M.update_body()
  -- Get all lines from the float buffer
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

  -- check if no content {""}
  if #lines == 1 and lines[1] == "" then
    lines = {}
  end

  -- update state
  state.todos[state.current_line] = { title = state.todos[state.current_line].title, body = lines }

  -- Mark buffer as saved
  vim.bo[buf].modified = false

  vim.schedule(function()
    render_body_signs()
    M.save_todos()
  end)

  close_and_focus(state.body_win, state.todos_win)

  print "Todo's Body Updated!"
end

function M.edit_body()
  if table_is_empty(state.todos) then
    return
  end

  -- Get current cursor
  local cursor = vim.api.nvim_win_get_cursor(state.todos_win)
  state.current_line = cursor[1]

  -- Get current line content
  local title_content = vim.api.nvim_buf_get_lines(state.titles_buf, state.current_line - 1, state.current_line, false)[1]
  local body_content = state.todos[state.current_line].body

  -- Create a new buffer for editing
  local buf = vim.api.nvim_create_buf(false, true)

  -- Set buffer content
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, body_content)

  -- Calculate floating window size and position
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.6)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Create floating window
  state.body_win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = " Edit Body - " .. title_content,
    title_pos = "center",
  })

  -- Set buffer options
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false

  vim.api.nvim_buf_set_keymap(buf, "n", "<esc>", ':lua require("todos").update_body()<CR>', { noremap = true })
end

--- MOVE UP

function M.move_up()
  -- Get current cursor
  local cursor = vim.api.nvim_win_get_cursor(state.todos_win)
  state.current_line = cursor[1]

  -- Check if we can move up
  if state.current_line <= 1 then
    return
  end

  -- update state
  table_swap_adjacent(state.todos, state.current_line, -1)

  -- update UI
  local current = vim.api.nvim_buf_get_lines(state.titles_buf, state.current_line - 1, state.current_line, false)[1]
  local previous = vim.api.nvim_buf_get_lines(state.titles_buf, state.current_line - 2, state.current_line - 1, false)[1]

  vim.api.nvim_set_option_value("modifiable", true, { buf = state.titles_buf })
  vim.api.nvim_buf_set_lines(state.titles_buf, state.current_line - 2, state.current_line - 1, false, { current })
  vim.api.nvim_buf_set_lines(state.titles_buf, state.current_line - 1, state.current_line, false, { previous })
  vim.api.nvim_set_option_value("modifiable", false, { buf = state.titles_buf })
  vim.api.nvim_set_option_value("modified", false, { buf = state.titles_buf })

  vim.api.nvim_win_set_cursor(state.todos_win, { state.current_line - 1, cursor[2] })

  vim.schedule(function()
    render_body_signs()
    M.save_todos()
  end)
end

--- MOVE DOWN

function M.move_down()
  -- Get current cursor
  local cursor = vim.api.nvim_win_get_cursor(state.todos_win)
  state.current_line = cursor[1]

  -- Check if we can move up
  if state.current_line >= vim.api.nvim_buf_line_count(state.titles_buf) then
    return
  end

  -- update state
  table_swap_adjacent(state.todos, state.current_line, 1) -- 1 for down, -1 for up

  -- update UI
  local current = vim.api.nvim_buf_get_lines(state.titles_buf, state.current_line - 1, state.current_line, false)[1]
  local next = vim.api.nvim_buf_get_lines(state.titles_buf, state.current_line, state.current_line + 1, false)[1]

  vim.api.nvim_set_option_value("modifiable", true, { buf = state.titles_buf })
  vim.api.nvim_buf_set_lines(state.titles_buf, state.current_line - 1, state.current_line, false, { next })
  vim.api.nvim_buf_set_lines(state.titles_buf, state.current_line, state.current_line + 1, false, { current })
  vim.api.nvim_set_option_value("modifiable", false, { buf = state.titles_buf })
  vim.api.nvim_set_option_value("modified", false, { buf = state.titles_buf })

  vim.api.nvim_win_set_cursor(state.todos_win, { state.current_line + 1, cursor[2] })

  vim.schedule(function()
    render_body_signs()
    M.save_todos()
  end)
end
-------------

function M.open()
  -- Create the buffer and focus
  state.titles_buf = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_win_set_buf(0, state.titles_buf)
  state.todos_win = vim.api.nvim_get_current_win()
  vim.api.nvim_buf_set_name(state.titles_buf, "Todos")

  load_todos()
  render_titles()
  render_body_signs()

  vim.api.nvim_set_option_value("modifiable", false, { buf = state.titles_buf })
  vim.api.nvim_set_option_value("modified", false, { buf = state.titles_buf }) -- get rid of [+]
  vim.api.nvim_set_option_value("number", false, { scope = "local" })
  vim.api.nvim_set_option_value("signcolumn", "yes:2", { scope = "local" })

  -- mappings
  vim.api.nvim_buf_set_keymap(state.titles_buf, "n", "=", ':lua require("todos").save_todos()<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(state.titles_buf, "v", "=", ':lua require("todos").save_todos()<CR>', { noremap = true, silent = true })

  -- Override common edit keys
  local keys = { "i", "I", "a", "A", "s", "S", "c", "C", "x", "X", "p", "P", "r", "R" }
  for _, key in ipairs(keys) do
    vim.api.nvim_buf_set_keymap(state.titles_buf, "n", key, ':lua require("todos").edit_todo()<CR>', { noremap = true, silent = true })
  end

  vim.api.nvim_buf_set_keymap(state.titles_buf, "n", "o", ':lua require("todos").new_todo()<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(state.titles_buf, "n", "O", ':lua require("todos").new_todo()<CR>', { noremap = true, silent = true })

  vim.api.nvim_buf_set_keymap(state.titles_buf, "n", "D", ':lua require("todos").delete_todo()<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(state.titles_buf, "n", "dd", ':lua require("todos").delete_todo()<CR>', { noremap = true, silent = true })

  vim.api.nvim_buf_set_keymap(state.titles_buf, "n", "<CR>", ':lua require("todos").edit_body()<CR>', { noremap = true, silent = true })

  vim.api.nvim_buf_set_keymap(state.titles_buf, "n", "<C-k>", ':lua require("todos").move_up()<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(state.titles_buf, "n", "<C-Up>", ':lua require("todos").move_up()<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(state.titles_buf, "n", "<C-j>", ':lua require("todos").move_down()<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(state.titles_buf, "n", "<C-Down>", ':lua require("todos").move_down()<CR>', { noremap = true, silent = true })
end

return M
