return {
  {
    "thesimonho/kanagawa-paper",
    -- {{{
    branch = "neovim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa-paper").setup {
        undercurl = false,
        transparent = false,
        gutter = false,
        dim_inactive = false, -- disabled when transparent
        terminal_colors = true,
        cache = true,
        styles = {
          comment = { italic = false },
          functions = { italic = false, bold = false },
          functionDeclaration = { bold = false },
          functionCall = { bold = false },
          typeDeclaration = { bold = false },
          controlFlow = { bold = false },
          keyword = { italic = false, bold = false },
          statement = { italic = false, bold = false },
          type = { italic = false },
        },
        colors = {
          theme = {},
          palette = {
            samuraiRed = "#e07b75",
            lotusRed3 = "#e07b75",
            roninYellow = "#f1a050",
          },
        }, -- override default palette and theme colors
        overrides = function() -- override highlight groups
          return {
            ["@variable.builtin"] = { fg = "#c4746e", italic = false },
            ["WinSeparator"] = { fg = "#363646" },
            ["StatusLineNC"] = { fg = "#858278", bg = "#0f0f15" },
            Bold = { bold = false },
            Italic = { italic = false },
            Boolean = { bold = false },
            CurSearch = { bold = false },
            ModeMsg = { bold = false },
            CursorLineNr = { bold = false },
            Title = { bold = false },
            DiffText = { bold = false },
            Conceal = { bold = false },
            PmenuMatch = { bold = false },
            PmenuMatchSel = { bold = false },
            FloatTitle = { bold = false },
            MatchParen = { bold = false },
            MiniFilesTitle = { bold = false },
            MiniFilesTitleFocused = { bold = false },
          }
        end,
      }

      vim.cmd "colorscheme kanagawa-paper"
    end,
    -- }}}
  },
  -- On windows machine : put sqlite3.dll in C:\Users\{user}\AppData\Local\Temp\nvim
  -- https://www.sqlite.org/2025/sqlite-dll-win-x64-3480000.zip
  {
    "folke/snacks.nvim",
    -- {{{
    priority = 1000, -- recommended by snacks (bigfile / quickfile must run early)
    lazy = false,
    -- stylua: ignore
    opts = {
      animate      = { enabled = false },
      bigfile      = { enabled = true },
      bufdelete    = { enabled = true },
      dashboard    = { enabled = false },
      debug        = { enabled = true },
      dim          = { enabled = false },
      git          = { enabled = true },
      gitbrowse    = { enabled = true },
      indent       = { enabled = false },
      input        = { enabled = false },
      lazygit      = {
        enabled = true,
        config = {
          gui = {
            nerdFontsVersion = "",
          },
        },
      },
      notifier     = { enabled = false },
      notify       = { enabled = false },
      picker       = {
        enabled = true,
        layout = {
          preset = "select",
          preview = false,
        },
        icons = {
          files = { enabled = false },
        },
        win = {
          input = {
            keys = {
              ["<C-q>"] = { "qflist_all", mode = { "n", "i" } },
            },
          },
        },
      },
      profiler     = { enabled = true },
      quickfile    = { enabled = true },
      rename       = { enabled = true },
      scope        = { enabled = true },
      scratch      = { enabled = true },
      scroll       = { enabled = false },
      statuscolumn = { enabled = false },
      terminal     = { enabled = true },
      toggle       = { enabled = false },
      words        = { enabled = false },
      zen          = { enabled = false },
    },
    keys = {
      {
        "<leader>x",
        function()
          Snacks.picker.pickers()
        end,
        desc = "[Picker] All Pickers",
      },
      {
        "<leader><leader>",
        function()
          Snacks.picker.smart()
        end,
        desc = "[Picker] Files",
      },
      {
        "<leader>p",
        function()
          Snacks.picker.projects()
        end,
        desc = "[Picker] Projects",
      },
      {
        "<leader>bb",
        function()
          Snacks.picker.buffers()
        end,
        desc = "[Picker] Buffers",
      },
      {
        "<F12>",
        function()
          Snacks.picker.files { dirs = { vim.fn.stdpath "config" }, title = "Nvim Config Files" }
        end,
        desc = "[Picker] Nvim Config Files",
      },
      {
        "<leader>E",
        function()
          Snacks.explorer()
        end,
        desc = "File Explorer",
      },
      {
        "<leader>/",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep",
      },
      {
        "gd",
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = "[Picker] Goto Definition",
      },
      {
        "gD",
        function()
          Snacks.picker.lsp_declarations()
        end,
        desc = "[Picker] Goto Declaration",
      },
      {
        "gr",
        function()
          Snacks.picker.lsp_references()
        end,
        nowait = true,
        desc = "[Picker] References",
      },
      {
        "gI",
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = "[Picker] Goto Implementation",
      },
      {
        "gy",
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = "[Picker] Goto T[y]pe Definition",
      },
      {
        "<leader>ls",
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = "[Picker] LSP Symbols",
      },
      {
        "<leader>lS",
        function()
          Snacks.picker.lsp_workspace_symbols()
        end,
        desc = "[Picker] LSP Workspace Symbols",
      },
      {
        "<leader>ld",
        function()
          Snacks.picker.diagnostics()
        end,
        desc = "[Picker] Diagnostics",
      },
      {
        "<leader>lD",
        function()
          Snacks.picker.diagnostics_buffer()
        end,
        desc = "[Picker] Buffer Diagnostics",
      },
      {
        "<leader>gb",
        function()
          Snacks.picker.git_branches()
        end,
        desc = "[Picker] Git Branches",
      },
      {
        "<leader>gg",
        function()
          Snacks.picker.git_status()
        end,
        desc = "[Picker] Git Status",
      },
      {
        "<leader>gl",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },
      {
        "<leader>bd",
        function()
          Snacks.bufdelete()
        end,
        desc = "Delete Buffer",
      },
      {
        "<F1>",
        function()
          Snacks.terminal.toggle(nil, {
            interactive = true,
            win = {
              width = 0.49,
              height = 0.95,
              row = 0,
              col = 0,
              relative = "editor",
              position = "float",
              style = "minimal",
              border = "single",
            },
            cwd = vim.fn.getcwd(),
            env = { nvterm = "1" },
          })
        end,
        desc = "Open terminal #1",
        mode = { "n", "t" },
      },
      {
        "<F2>",
        function()
          Snacks.terminal.toggle(nil, {
            interactive = true,
            win = {
              width = 0.49,
              height = 0.95,
              row = 0,
              col = 0.51,
              relative = "editor",
              position = "float",
              style = "minimal",
              border = "single",
            },
            cwd = vim.fn.getcwd(),
            env = { nvterm = "2" },
          })
        end,
        desc = "Open terminal #2",
        mode = { "n", "t" },
      },
      {
        "<F3>",
        function()
          Snacks.terminal.toggle(nil, {
            interactive = true,
            win = { position = "float", border = "double" },
            cwd = vim.fn.getcwd(),
            env = { nvterm = "3" },
          })
        end,
        desc = "Open terminal #3",
        mode = { "n", "t" },
      },
    },
    -- }}}
  },
  {
    "nvim-mini/mini.files",
    -- {{{
    version = false,
    init = function()
      -- mini.files is lazy-loaded, so its `use_as_default_explorer` hook doesn't exist yet
      -- when a directory is opened (e.g. `nvim .`). Load it on the first directory buffer.
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("MiniFilesLazyDirectory", { clear = true }),
        callback = function(ev)
          local path = vim.api.nvim_buf_get_name(ev.buf)
          if path == "" or vim.fn.isdirectory(path) == 0 then
            return
          end
          vim.schedule(function()
            if vim.api.nvim_buf_is_valid(ev.buf) then
              vim.bo[ev.buf].bufhidden = "wipe"
              -- tell mini.files this dir buffer was handled: on re-enter (after closing the
              -- explorer) it deletes the buffer instead of opening the explorer again
              vim.b[ev.buf].minifiles_processed_dir = true
            end
            require("mini.files").open(path, false)
          end)
          return true -- delete this autocmd, mini.files handles directories from now on
        end,
      })
    end,
    opts = {
      windows = {
        preview = false,
        width_focus = 30,
        width_preview = 30,
      },
      content = { prefix = function() end }, -- hide icons
      mappings = {
        close = "<leader>e",
        go_in = "l",
        go_in_plus = "<Right>",
        go_out = "h",
        go_out_plus = "<Left>",
        mark_goto = "'",
        mark_set = "m",
        reset = "<BS>",
        reveal_cwd = "@",
        show_help = "g?",
        synchronize = "=",
        trim_left = "<",
        trim_right = ">",
      },
      options = {
        use_as_default_explorer = true,
      },
    },
    keys = {
      {
        "<leader><Esc>",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (Directory of Current File)",
      },
      {
        "<leader>e",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Open mini.files (cwd)",
      },
    },
    config = function(_, opts)
      require("mini.files").setup(opts)

      local show_dotfiles = true
      local filter_show = function(fs_entry)
        return true
      end
      local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, ".")
      end

      local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        require("mini.files").refresh { content = { filter = new_filter } }
      end

      local files_set_cwd = function()
        local cur_entry_path = MiniFiles.get_fs_entry().path
        local cur_directory = vim.fs.dirname(cur_entry_path)
        if cur_directory ~= nil then
          vim.fn.chdir(cur_directory)
        end
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id

          vim.keymap.set("n", opts.mappings and opts.mappings.toggle_hidden or "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle hidden files" })

          vim.keymap.set("n", opts.mappings and opts.mappings.change_cwd or "gc", files_set_cwd, { buffer = args.data.buf_id, desc = "Set cwd" })
        end,
      })
    end,
    -- }}}
  },
  {
    "nvim-mini/mini.diff",
    -- {{{
    version = false,
    event = "VeryLazy",
    opts = {
      delay = {
        text_change = 100, -- default 200
      },
      view = {
        style = "sign",
        signs = {
          add = "▎",
          change = "▎",
          delete = "_",
        },
      },
    },
    -- }}}
  },
  {
    "nvim-mini/mini.align",
    -- {{{
    version = false,
    keys = {
      { "ga", mode = { "n", "v", "x" } },
      { "gA", mode = { "n", "v", "x" } },
    },
    config = function()
      require("mini.align").setup()
    end,
    -- }}}
  },
  {
    "nvim-mini/mini.surround",
    -- {{{
    version = false,
    keys = {
      { "sa", mode = { "n", "v", "x" } },
      { "sd", mode = { "n", "v", "x" } },
      { "sr", mode = { "n", "v", "x" } },
    },
    config = function()
      require("mini.surround").setup()
    end,
    -- }}}
  },
  {
    -- Improves the built-in `gc` commenting (JSX/TSX and other injected languages)
    "folke/ts-comments.nvim",
    -- {{{
    opts = {},
    event = "VeryLazy",
    -- }}}
  },
  {
    -- `main` branch: no lazy-loading, no `nvim-treesitter.configs` module.
    -- Installing parsers requires the `tree-sitter` CLI and a C compiler in PATH.
    "nvim-treesitter/nvim-treesitter",
    -- {{{
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local parsers = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "toml",
        "html",
        "css",
        "markdown",
        "markdown_inline",
        "graphql",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "vimdoc",
        "go",
        "c",
      }

      -- compile parsers with zig (scoop install zig); only affects nvim and its child processes.
      -- bin/zig-cc.cmd fixes the target triple that zig can't parse.
      if jit.os == "Windows" and vim.fn.executable "zig" == 1 then
        vim.env.CC = vim.fn.stdpath "config" .. "\\bin\\zig-cc.cmd"
      end

      if vim.fn.executable "tree-sitter" == 1 then
        require("nvim-treesitter").install(parsers) -- no-op for parsers already installed
      end

      -- enable highlighting and indentation for every filetype that has a parser
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
        callback = function(ev)
          if pcall(vim.treesitter.start, ev.buf) then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
    -- }}}
  },

  {
    "nvim-mini/mini.completion",
    -- {{{
    version = false,
    enabled = true,
    event = "VeryLazy",
    keys = {
      {
        "<tab>",
        [[pumvisible() ? "\<c-n>" : "\<tab>"]],
        mode = "i",
        expr = true,
      },
      {
        "<s-tab>",
        [[pumvisible() ? "\<c-p>" : "\<s-tab>"]],
        mode = "i",
        expr = true,
      },
    },
    config = function()
      require("mini.completion").setup {
        window = {
          info = { border = "single" },
          signature = { border = "single" },
        },
        lsp_completion = {
          source_func = "completefunc",
          auto_setup = true,
        },
      }
    end,
    -- }}}
  },

  {
    -- Only provides the server configs (lsp/*.lua); setup uses the built-in vim.lsp API
    "neovim/nvim-lspconfig",
    -- {{{
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Disable semantic tokens (too slow), before any buffer attaches
      vim.lsp.config("*", {
        on_init = function(client)
          client.server_capabilities.semanticTokensProvider = nil
        end,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(ev)
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
          end

          map({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, "See available code actions")
          map("n", "<leader>r", vim.lsp.buf.rename, "Rename symbol")
          map("n", "(d", function()
            vim.diagnostic.jump { count = -1 }
          end, "Go to previous diagnostic")
          map("n", ")d", function()
            vim.diagnostic.jump { count = 1 }
          end, "Go to next diagnostic")
          map("n", "<leader>k", vim.lsp.buf.hover, "Show documentation for what is under cursor")
        end,
      })

      -- Highlight line number instead of having icons in sign column
      local sev = vim.diagnostic.severity
      vim.diagnostic.config {
        virtual_text = {
          prefix = " ●",
        },
        signs = {
          text = { [sev.ERROR] = "", [sev.WARN] = "", [sev.INFO] = "", [sev.HINT] = "" },
          numhl = {
            [sev.ERROR] = "DiagnosticSignError",
            [sev.WARN] = "DiagnosticSignWarn",
            [sev.INFO] = "DiagnosticSignInfo",
            [sev.HINT] = "DiagnosticSignHint",
          },
        },
      }

      vim.lsp.enable { "vtsls", "gopls" }
    end,
    -- }}}
  },
  {
    "stevearc/conform.nvim",
    -- {{{
    event = { "BufWritePre" },
    keys = {
      {
        "<leader>fm",
        function()
          require("conform").format { async = true, lsp_fallback = true }
        end,
        desc = "Format file",
      },
    },
    opts = {
      async = true,
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports", "gofumpt" },
        javascript = { "prettier", "prettierd", stop_after_first = true },
        typescript = { "prettier", "prettierd", stop_after_first = true },
        javascriptreact = { "prettier", "prettierd", stop_after_first = true },
        typescriptreact = { "prettier", "prettierd", stop_after_first = true },
        css = { "prettier", "prettierd", stop_after_first = true },
        html = { "prettier", "prettierd", stop_after_first = true },
        json = { "prettier", "prettierd", stop_after_first = true },
        yaml = { "prettier", "prettierd", stop_after_first = true },
        markdown = { "prettier", "prettierd", stop_after_first = true },
        graphql = { "prettier", "prettierd", stop_after_first = true },
      },
      format_on_save = { timeout_ms = 500 },
      default_format_opts = {
        lsp_format = "fallback",
      },
    },
    -- }}}
  },
}
