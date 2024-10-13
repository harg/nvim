return {
  "nvim-lua/plenary.nvim",
  {
    "echasnovski/mini.files",
    opts = {
      windows = {
        preview = false,
        width_focus = 30,
        width_preview = 30,
      },
      content = { prefix = function() end },
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
        -- Whether to use for editing directories
        -- Disabled by default in LazyVim because neo-tree is used for that
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
        require("mini.files").refresh({ content = { filter = new_filter } })
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
  },
  {
    "echasnovski/mini.diff",
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
  },

  {
    "echasnovski/mini.pick",
    keys = {
      {
        "<leader><leader>",
        function()
          require("mini.pick").builtin.files()
        end,
        desc = "Open mini.pick (Files)",
      },
    },
    config = function()
      local pick = require('mini.pick')
      pick.setup({
        source = { show = pick.default_show }, --disable icons
      })
    end
  },
  { 
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    config = function()
      require("rose-pine").setup({
        styles = {
          bold = false,
          italic = false,
          transparency = false,
        },
      })

      vim.cmd("colorscheme rose-pine-moon")
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    config = function()
      -- import nvim-treesitter plugin
      local treesitter = require("nvim-treesitter.configs")

      -- configure treesitter
      treesitter.setup({ -- enable syntax highlighting
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
      })
    end,
  },

  {
    "echasnovski/mini.completion", 
    event = "VeryLazy",
    version = false,
    config = function()
      require("mini.completion").setup()
    end
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- import lspconfig plugin
      local lspconfig = require("lspconfig")

      -- import cmp-nvim-lsp plugin
      -- local cmp_nvim_lsp = require("cmp_nvim_lsp")

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
          opts.desc = "Show LSP references"
          keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

          opts.desc = "Go to declaration"
          keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

          opts.desc = "Show LSP definitions"
          keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

          opts.desc = "Show LSP implementations"
          keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

          opts.desc = "Show LSP type definitions"
          keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

          opts.desc = "See available code actions"
          keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

          opts.desc = "Smart rename"
          keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

          -- opts.desc = "Show buffer diagnostics"
          -- keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

          opts.desc = "Show line diagnostics"
          keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

          opts.desc = "Go to previous diagnostic"
          keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

          opts.desc = "Go to next diagnostic"
          keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

          opts.desc = "Show documentation for what is under cursor"
          keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

          opts.desc = "Restart LSP"
          keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
        end,
      })

      -- Change the Diagnostic symbols in the sign column (gutter)
      -- local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      local signs = { Error = "●", Warn = "●", Hint = "●", Info = "●" }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      vim.diagnostic.config({
        virtual_text = {
          prefix = '●'
        }
      })


      -- local lspservers =  {"tsserver", "html", "cssls", "tailwindcss", "emmet_ls", "gopls"}
      local lspservers =  {"ts_ls", "gopls"}
      for i, v in ipairs(lspservers) do
        lspconfig[v].setup({})
      end

      -- used to enable autocompletion (assign to every lsp server config)
      -- local capabilities = cmp_nvim_lsp.default_capabilities()


      -- local lspservers =  {"tsserver", "html", "cssls", "tailwindcss", "emmet_ls", "gopls"}
      -- local lspservers =  {"ts_ls", "gopls"}
      -- for i, v in ipairs(lspservers) do
      --   lspconfig[v].setup({
      --     capabilities = capabilities,
      --   })
      -- end


      --
      -- mason_lspconfig.setup_handlers({
      --   -- default handler for installed servers
      --   function(server_name)
      --     lspconfig[server_name].setup({
      --       capabilities = capabilities,
      --     })
      --   end
      -- ["svelte"] = function()
      --   -- configure svelte server
      --   lspconfig["svelte"].setup({
      --     capabilities = capabilities,
      --     on_attach = function(client, bufnr)
      --       vim.api.nvim_create_autocmd("BufWritePost", {
      --         pattern = { "*.js", "*.ts" },
      --         callback = function(ctx)
      --           -- Here use ctx.match instead of ctx.file
      --           client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
      --         end,
      --       })
      --     end,
      --   })
      -- end,
      -- ["graphql"] = function()
      --   -- configure graphql language server
      --   lspconfig["graphql"].setup({
      --     capabilities = capabilities,
      --     filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
      --   })
      -- end,
      -- ["emmet_ls"] = function()
      --   -- configure emmet language server
      --   lspconfig["emmet_ls"].setup({
      --     capabilities = capabilities,
      --     filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
      --   })
      -- end,
      -- ["lua_ls"] = function()
      --   -- configure lua server (with special settings)
      --   lspconfig["lua_ls"].setup({
      --     capabilities = capabilities,
      --     settings = {
      --       Lua = {
      --         -- make the language server recognize "vim" global
      --         diagnostics = {
      --           globals = { "vim" },
      --         },
      --         completion = {
      --           callSnippet = "Replace",
      --         },
      --       },
      --     },
      --   })
      -- end,
      --   })
    end,
  }
}
