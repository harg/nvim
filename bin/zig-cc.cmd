@echo off
rem C compiler wrapper used by nvim-treesitter (`tree-sitter build`), see lua/plugins/init.lua.
rem tree-sitter passes the Rust target "x86_64-pc-windows-msvc", which zig can't parse:
rem rewrite it to zig's mingw target (bundled libc, no Visual Studio needed).
setlocal
set "args=%*"
set "args=%args:x86_64-pc-windows-msvc=x86_64-windows-gnu%"
zig cc %args%
