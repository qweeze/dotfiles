-- LSP Configuration for Neovim 0.11+

return {
  -- Mason for LSP server management
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- Mason-lspconfig bridge
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        -- These require npm: pyright, ts_ls, svelte, html, cssls, jsonls
        -- These require go: gopls
        -- Install with: brew install node go
      },
      automatic_installation = false, -- Don't auto-install to avoid errors for missing tools
    },
  },

  -- LSP Configuration using Neovim 0.11 native API
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Diagnostic configuration
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
        },
      })

      -- LSP keymaps on attach (using LspAttach autocmd)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(ev)
          local bufnr = ev.buf
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          local opts = { buffer = bufnr, silent = true }

          -- Navigation
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
          vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to references" }))
          vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Go to type definition" }))

          -- Hover and signature
          vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
          vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))

          -- Actions
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
          vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))
          vim.keymap.set("v", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, vim.tbl_extend("force", opts, { desc = "Format selection" }))

          -- Diagnostics
          vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Line diagnostics" }))
          vim.keymap.set("n", "<leader>cq", vim.diagnostic.setloclist, vim.tbl_extend("force", opts, { desc = "Diagnostics to loclist" }))

          -- Workspace
          vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, vim.tbl_extend("force", opts, { desc = "Add workspace folder" }))
          vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, vim.tbl_extend("force", opts, { desc = "Remove workspace folder" }))
          vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, vim.tbl_extend("force", opts, { desc = "List workspace folders" }))

          -- Highlight references on hold
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_group = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = false })
            vim.api.nvim_clear_autocmds({ buffer = bufnr, group = highlight_group })
            vim.api.nvim_create_autocmd("CursorHold", {
              group = highlight_group,
              buffer = bufnr,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
              group = highlight_group,
              buffer = bufnr,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- Configure LSP servers using vim.lsp.config (Neovim 0.11+)
      -- Lua
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      -- Python
      vim.lsp.config("pyright", {
        capabilities = capabilities,
        on_init = function(client)
          local root = client.root_dir or vim.fn.getcwd()
          local venv_path = root .. "/.venv"
          if vim.fn.isdirectory(venv_path) == 1 then
            client.settings = vim.tbl_deep_extend("force", client.settings or {}, {
              python = {
                venvPath = root,
                venv = ".venv",
                pythonPath = venv_path .. "/bin/python",
              },
            })
            client.notify("workspace/didChangeConfiguration", { settings = client.settings })
          end
        end,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      })

      -- TypeScript/JavaScript
      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
      })

      -- Rust
      vim.lsp.config("rust_analyzer", {
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
            },
          },
        },
      })

      -- Go
      vim.lsp.config("gopls", {
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
          },
        },
      })

      -- Svelte
      vim.lsp.config("svelte", {
        capabilities = capabilities,
      })

      -- HTML
      vim.lsp.config("html", {
        capabilities = capabilities,
      })

      -- CSS
      vim.lsp.config("cssls", {
        capabilities = capabilities,
      })

      -- JSON
      vim.lsp.config("jsonls", {
        capabilities = capabilities,
      })

      -- Enable servers (only those that are installed will actually start)
      -- Use :Mason to install additional servers after installing required tools
      -- npm-based: pyright, ts_ls, svelte, html, cssls, jsonls (brew install node)
      -- go-based: gopls (brew install go)
      vim.lsp.enable({
        "lua_ls",
        "pyright",
        "ts_ls",
        "rust_analyzer",
        "gopls",
        "svelte",
        "html",
        "cssls",
        "jsonls",
      })
    end,
  },
}
