return {
  -- {
  --   "zenbones-theme/zenbones.nvim",
  --   -- Optionally install Lush. Allows for more configuration or extending the colorscheme
  --   -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
  --   -- In Vim, compat mode is turned on as Lush only works in Neovim.
  --   dependencies = "rktjmp/lush.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   -- you can set set configuration options here
  --   config = function()
  --     vim.g.zenbones_darken_comments = 45
  --     vim.cmd.colorscheme "zenwritten"
  --   end,
  -- },
  -- {
  --   "vague2k/vague.nvim",
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
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa-paper").setup {
        undercurl = false,
        transparent = false,
        gutter = false,
        dimInactive = false, -- disabled when transparent
        terminalColors = true,
        commentStyle = { italic = false },
        functionStyle = { italic = false },
        keywordStyle = { italic = false, bold = false },
        statementStyle = { italic = false, bold = false },
        typeStyle = { italic = false },
        -- colors = { theme = {}, palette = {} }, -- override default palette and theme colors
        -- overrides = function() -- override highlight groups
        --   return {}
        -- end,
      }

      -- setup must be called before loading
      vim.cmd "colorscheme kanagawa-paper"
    end,
  },
  {
    "echasnovski/mini.icons",
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
    "echasnovski/mini.extra",
    -- {{{
    version = false,
    config = function()
      require("mini.extra").setup()
    end,
    -- }}}
  },
  {
    "echasnovski/mini.files",
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
    "echasnovski/mini.diff",
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
    "echasnovski/mini.align",
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
    "echasnovski/mini.surround",
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
    "echasnovski/mini.comment",
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
    "echasnovski/mini.pick",
    -- {{{
    version = false,
    keys = {
      {
        "<leader><leader>",
        function()
          require("mini.pick").builtin.files()
        end,
        desc = "Open mini.pick (Files)",
      },
      {
        "<leader>/",
        function()
          require("mini.pick").builtin.grep()
        end,
        desc = "Open mini.pick (Grep)",
      },
      {
        "<F12>",
        function()
          require("mini.pick").builtin.files(nil, { source = { cwd = vim.fn.stdpath "config" } })
        end,
        desc = "Open mini.pick (Files)",
      },
      {
        "<leader>b",
        function()
          require("mini.pick").builtin.buffers()
        end,
        desc = "Open mini.pick (Buffers)",
      },
      {
        "gr",
        function()
          require("mini.extra").pickers.lsp { scope = "references" }
        end,
        desc = "Open mini.pick (LSP References)",
      },
      {
        "gD",
        function()
          require("mini.extra").pickers.lsp { scope = "declaration" }
        end,
        desc = "Open mini.pick (LSP Declaration)",
      },
      {
        "gd",
        function()
          require("mini.extra").pickers.lsp { scope = "definition" }
        end,
        desc = "Open mini.pick (LSP Definition)",
      },
      {
        "gi",
        function()
          require("mini.extra").pickers.lsp { scope = "implementation" }
        end,
        desc = "Open mini.pick (LSP Implementation)",
      },
      {
        "gy",
        function()
          require("mini.extra").pickers.lsp { scope = "type_definition" }
        end,
        desc = "Open mini.pick (LSP Type Definition)",
      },
      {
        "<leader>d",
        function()
          require("mini.extra").pickers.diagnostic { scope = "current" }
        end,
        desc = "Open mini.pick (LSP Diagnostics)",
      },
      {
        "<leader>D",
        function()
          require("mini.extra").pickers.diagnostic { scope = "all" }
        end,
        desc = "Open mini.pick (LSP Workspace Diagnostics)",
      },
      {
        "<leader>s",
        function()
          require("mini.extra").pickers.lsp { scope = "document_symbol" }
        end,
        desc = "Open mini.pick (LSP Symbols)",
      },
      {
        "<leader>S",
        function()
          require("mini.extra").pickers.lsp { scope = "workspace_symbol" }
        end,
        desc = "Open mini.pick (LSP Workspace Symbols)",
      },
      {
        "<leader>?",
        function()
          require("mini.extra").pickers.commands()
        end,
        desc = "Open mini.pick (Neovim commands)",
      },
      {
        "<leader>gg",
        function()
          if jit.os == "Windows" then
            command = { "CMD", "/c", "git ls-files --others --exclude-standard & git diff --name-only" }
          else
            command = { "sh", "-c", "git ls-files --others --exclude-standard && git diff --name-only" }
          end
          require("mini.pick").builtin.cli({ command = command }, { source = { name = "Git added & modified" } })
        end,
        desc = "Open mini.pick (Buffers)",
      },
      {
        "<leader>gb",
        mode = { "n" },
        function()
          require("mini.extra").pickers.git_branches({ scope = "local" }, {
            source = {
              name = "Git Branches",
              choose = function(item)
                local branch = item:match "%s+(%S+)%s+"
                local on_exit = function(obj)
                  if obj.code == 0 then
                    print("Switch to branch '" .. branch .. "'")
                  else
                    print(vim.inspect(obj))
                    print("Failed to switch branch '" .. branch .. "'")
                  end
                end
                vim.system({ "git", "switch", branch }, { text = false }, on_exit)
              end,
            },
          })
        end,
        desc = "Open mini.pick (Git Branches)",
      },
      {
        "<leader>$",
        function()
          local preview_func = function(buf_id, item)
            -- local lines = vim.split(vim.inspect(item), "\n")
            local lines = { "Name : " .. item }
            vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
          end

          local show_func = function(buf_id, items_arr, query)
            -- local lines = vim.tbl_map(function(x)
            --   return "Gay " .. x
            -- end, items_arr)
            -- vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
            local prefix = "Gay "

            for i, str in ipairs(items_arr) do
              items_arr[i] = prefix .. str
            end
            MiniPick.default_show(buf_id, items_arr, query)
          end

          MiniPick.start {
            source = {
              items = { "Harold", "Alix", "Eugénie", "Gustave" },
              preview = preview_func,
              show = show_func,
              choose = function(item)
                print("Hello " .. item)
              end,
            },
          }
        end,
        desc = "Open mini.pick (Example)",
      },
    },
    config = function()
      local pick = require "mini.pick"
      pick.setup {
        source = {
          show = pick.default_show, --disable icons
        },
        mappings = {
          choose_in_split = "<A-s>",
          choose_in_vsplit = "<C-s>",
          caret_right = "", -- hacky : disable move carret to right and emulate pressing <CR> with <Right>
          my_choose = {
            char = "<Right>",
            func = function()
              vim.api.nvim_input "\r"
            end,
          },
        },
        options = {
          use_cache = true,
        },
      }
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
    "echasnovski/mini.completion",
    -- {{{
    version = false,
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
      local lspservers = { "ts_ls", "gopls" }
      for i, v in ipairs(lspservers) do
        lspconfig[v].setup {}
      end
    end,
    -- }}}
  },
  -- {
  --   "nanozuki/tabby.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     -- require("tabby").setup {
  --     --   preset = "active_wins_at_tail",
  --     --   option = {
  --     --     nerdfont = false,
  --     --     -- lualine_theme = 'rose-pine',
  --     --   },
  --     -- }
  --     local theme = {
  --       fill = "TabLineFill",
  --       -- fill = { fg = "#2a273f", bg = "#1f1c2c" }, --rosepine
  --       head = "TabLine",
  --       current_tab = "TabLineSel",
  --       tab = "TabLine",
  --       win = "TabLine",
  --       tail = "TabLine",
  --     }
  --     require("tabby").setup {
  --       line = function(line)
  --         return {
  --           line.tabs().foreach(function(tab)
  --             local hl = tab.is_current() and theme.current_tab or theme.tab
  --             return {
  --               line.sep("", hl, theme.fill),
  --               tab.name(),
  --               tab.close_btn "🗙",
  --               line.sep("", hl, theme.fill),
  --               hl = hl,
  --               margin = "  ",
  --             }
  --           end),
  --           hl = theme.fill,
  --         }
  --       end,
  --       -- option = {}, -- setup modules' option,
  --     }
  --   end,
  -- },
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
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        graphql = { "prettierd", "prettier", stop_after_first = true },
      },
      format_on_save = { timeout_ms = 500 },
      default_format_opts = {
        lsp_format = "fallback",
      },
    },
    -- }}}
  },
}
