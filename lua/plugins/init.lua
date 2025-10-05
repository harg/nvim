return {
  -- {
  --   "vague2k/vague.nvim",
  --   -- {{{
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("vague").setup {
  --       style = {
  --         comments = "none",
  --         strings = "none",
  --       },
  --       colors = {
  --         hint = "#7894ab",
  --       },
  --     }
  --
  --     vim.cmd "colorscheme vague"
  --
  --     group_styles = {
  --       ["StatusLine"] = { fg = "#646477", bg = "#222222" },
  --       ["WinSeparator"] = { fg = "#444444" },
  --       ["EndOfBuffer"] = { fg = "#444444" },
  --     }
  --
  --     for group, style in pairs(group_styles) do
  --       vim.api.nvim_set_hl(0, group, style)
  --     end
  --   end,
  --   -- }}}
  -- },
  -- {
  --   "rose-pine/neovim",
  --   -- {{{
  --   name = "rose-pine",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("rose-pine").setup {
  --       styles = {
  --         bold = false,
  --         italic = false,
  --         transparency = false,
  --       },
  --     }
  --
  --     vim.cmd "colorscheme rose-pine-moon"
  --   end,
  --   -- }}}
  -- },
  {
    "sho-87/kanagawa-paper.nvim",
    -- {{{
    -- Generate optimized colorscheme
    -- > Lazy Load kanagawa-paper.nvim
    -- > ExColors and save. Load the generated colorscheme in init.lua
    lazy = true, -- don't load by default, only on demand for generating optimized colorscheme
    event = "VeryLazy",
    -- priority = 1000,
    config = function()
      require("kanagawa-paper").setup {
        undercurl = false,
        transparent = false,
        gutter = false,
        dim_inactive = false, -- disabled when transparent
        terminal_colors = true,
        cache = false,
        styles = {
          comment = { italic = false },
          functions = { italic = false },
          keyword = { italic = false, bold = false },
          statement = { italic = false, bold = false },
          type = { italic = false },
        },
        colors = {
          theme = {},
          palette = {
            -- samuraiRed = "#e82424",
            -- roninYellow = "#ff9e3b",
            --
            samuraiRed = "#e07b75",
            lotusRed3 = "#e07b75",
            roninYellow = "#f1a050",
          },
        }, -- override default palette and theme colors
        overrides = function() -- override highlight groups
          return {
            ["@variable.builtin"] = { fg = "#c4746e", italic = false },
          }
        end,
      }

      vim.cmd "colorscheme kanagawa-paper"
    end,
    -- }}}
  },
  {
    "webhooked/kanso.nvim",
    -- {{{
    lazy = true,
    priority = 1000,
    config = function()
      -- Default options:
      require("kanso").setup {
        compile = false, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = false },
        functionStyle = {},
        keywordStyle = { italic = false },
        statementStyle = {},
        typeStyle = {},
        disableItalics = true,
        transparent = false, -- do not set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = { -- add/modify theme and palette colors
          palette = {},
          theme = { zen = {}, pearl = {}, ink = {}, all = {} },
        },
        overrides = function(colors) -- add/modify highlights
          return {}
        end,
        theme = "pearl", -- Load "zen" theme
        background = { -- map the value of 'background' option to a theme
          dark = "zen", -- try "ink" !
          light = "pearl",
        },
      }

      -- vim.cmd "colorscheme kanso-pearl"
    end,
    -- }}}
  },
  {
    "wtfox/jellybeans.nvim",
    -- {{{
    lazy = true,
    priority = 1000,
    opts = {}, -- Optional
    -- }}}
  },
  {
    "nvim-mini/mini.icons",
    opts = {},
    specs = {
      { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  {
    "nvim-mini/mini.sessions",
    version = false,
    lazy = false,
    event = "VeryLazy",
    config = function()
      require("mini.sessions").setup {
        autoread = true,
        force = { read = false, write = true, delete = true },
      }
    end,
  },
  -- On windows machine : put sqlite3.dll in C:\Users\{user}\AppData\Local\Temp\nvim
  -- https://www.sqlite.org/2025/sqlite-dll-win-x64-3480000.zip
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    event = "VeryLazy",
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
          }
        }
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
          files = { enabled = false } 
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
        "<leader>lg",
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
  },
  -- {
  --   "nvim-mini/mini.extra",
  --   -- {{{
  --   version = false,
  --   config = function()
  --     require("mini.extra").setup()
  --   end,
  --   -- }}}
  -- },
  {
    "nvim-mini/mini.files",
    -- {{{
    version = false,
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

          vim.keymap.set(
            "n",
            opts.mappings and opts.mappings.toggle_hidden or "g.",
            toggle_dotfiles,
            { buffer = buf_id, desc = "Toggle hidden files" }
          )

          vim.keymap.set(
            "n",
            opts.mappings and opts.mappings.change_cwd or "gc",
            files_set_cwd,
            { buffer = args.data.buf_id, desc = "Set cwd" }
          )
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
    delay = {
      text_change = 100, -- default 200
    },
    opts = {
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
    "folke/ts-comments.nvim",
    -- {{{
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has "nvim-0.10.0" == 1,
    -- }}}
  },
  {
    "nvim-mini/mini.comment",
    -- {{{
    version = false,
    event = "VeryLazy",
    keys = {
      { "gc", mode = { "n", "v", "x" } },
    },
    config = function()
      require("mini.comment").setup()
    end,
    -- }}}
  },
  {
    "nvim-treesitter/nvim-treesitter",
    -- {{{
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    config = function()
      -- import nvim-treesitter plugin
      local treesitter = require "nvim-treesitter.configs"

      -- configure treesitter
      treesitter.setup { -- enable syntax highlighting
        highlight = {
          enable = true,
        },
        -- enable indentation
        indent = { enable = true },
        -- ensure these language parsers are installed
        ensure_installed = {
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
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<cr>",
            node_incremental = "<cr>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      }
    end,
    -- }}}
  },

  {
    "nvim-mini/mini.completion",
    -- {{{
    version = false,
    -- commit = "633b22be88dcc937b5b4e023464d2741ff03da7d",
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
    "neovim/nvim-lspconfig",
    -- {{{
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- import lspconfig plugin
      local lspconfig = require "lspconfig"

      local keymap = vim.keymap -- for conciseness

      -- Disable semantic tokens (too slow)
      lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
        on_attach = function(client)
          client.server_capabilities.semanticTokensProvider = nil
        end,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf, silent = true }

          -- set keybinds

          opts.desc = "See available code actions"
          keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

          opts.desc = "Rename symbol"
          keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)

          opts.desc = "Go to previous diagnostic"
          keymap.set("n", "(d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

          opts.desc = "Go to next diagnostic"
          keymap.set("n", ")d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

          opts.desc = "Show documentation for what is under cursor"
          keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
        end,
      })

      -- Change the Diagnostic symbols in the sign column (gutter)
      -- local signs = { Error = "●", Warn = "●", Hint = "●", Info = "●" }
      -- for type, icon in pairs(signs) do
      --   local hl = "DiagnosticSign" .. type
      --   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      -- end

      -- Highlight line number instead of having icons in sign column
      for _, diag in ipairs { "Error", "Warn", "Info", "Hint" } do
        vim.fn.sign_define("DiagnosticSign" .. diag, {
          text = "",
          texthl = "DiagnosticSign" .. diag,
          linehl = "",
          numhl = "DiagnosticSign" .. diag,
        })
      end

      vim.diagnostic.config {
        virtual_text = {
          prefix = " ●",
        },
      }

      -- local lspservers =  {"ts_ls", "html", "cssls", "tailwindcss", "emmet_ls", "gopls", "denols"}
      local lspservers = { "vtsls", "gopls" }
      for i, v in ipairs(lspservers) do
        lspconfig[v].setup {}
      end
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
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- vim.g.db_ui_use_nerd_fonts = 1
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "sql", "mysql", "plsql" },
        callback = function()
          vim.bo.omnifunc = "vim_dadbod_completion#omni"
          vim.b.minicompletion_config = { fallback_action = "<C-x><C-o>" }
          vim.opt.cmdheight = 2 -- remove "hit enter messages" by increasing command line height
        end,
      })
    end,
  },
  {
    "aileot/ex-colors.nvim",
    cmd = { "ExColors" },
    opts = {},
  },
  {
    "atiladefreitas/dooing",
    event = "VeryLazy",
    config = function()
      require("dooing").setup {

        window = {
          width = 75, -- Width of the floating window
          height = 30, -- Height of the floating window
          border = "rounded", -- Border style
          position = "top", -- Window position: 'right', 'left', 'top', 'bottom', 'center',
          -- 'top-right', 'top-left', 'bottom-right', 'bottom-left'
          padding = {
            top = 1,
            bottom = 1,
            left = 2,
            right = 2,
          },
        },

        keymaps = {
          close_window = "<leader>td",
        },

        formatting = {
          pending = {
            icon = "○",
            format = { "icon", "notes_icon", "text", "due_date", "ect" },
          },
          in_progress = {
            icon = "•",
            format = { "icon", "text", "due_date", "ect" },
          },
          done = {
            icon = "✓",
            format = { "icon", "notes_icon", "text", "due_date", "ect" },
          },
        },

        quick_keys = false, -- Quick keys window

        notes = {
          icon = "§",
        },
      }
    end,
  },
}
