return {
    "neovim/nvim-lspconfig",
    -- lazy = false (em vez de event = BufReadPre/BufNewFile): precisa correr
    -- no startup, antes do primeiro arquivo da linha de comando ser lido —
    -- senão o autocmd de FileType registrado por vim.lsp.enable() chega
    -- depois que o FileType do próprio buffer de abertura já disparou, e o
    -- LSP nunca anexa nesse primeiro arquivo.
    lazy = false,
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        -- "saghen/blink.cmp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        -- NOTE: LSP Keybinds

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Buffer local mappings
                -- Check `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf, silent = true }

                -- keymaps
                opts.desc = "Show LSP references"
                vim.keymap.set("n", "<leader>gr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references


                --opts.desc = "Go to declaration"
                --vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

                opts.desc = "Show LSP definitions"
                vim.keymap.set("n", "<leader>gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

                --opts.desc = "Show LSP implementations"
                --vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

                --opts.desc = "Show LSP type definitions"
                --vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

                opts.desc = "See available code actions"
                vim.keymap.set({ "n", "v" }, "<leader>ca", function() vim.lsp.buf.code_action() end, opts) -- see available code actions, in visual mode will apply to selection

                opts.desc = "Smart rename"
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

                opts.desc = "Show buffer diagnostics"
                vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

                opts.desc = "Show line diagnostics"
                vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

                opts.desc = "Show documentation for what is under cursor"
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

                opts.desc = "Restart LSP"
                vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            end,
        })

        -- Define sign icons for each severity
        local signs = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.HINT]  = "󰠠 ",
            [vim.diagnostic.severity.INFO]  = " ",
        }

        -- Set the diagnostic config with all icons
        vim.diagnostic.config({
            signs = {
                text = signs -- Enable signs in the gutter
            },
            virtual_text = true,  -- Specify Enable virtual text for diagnostics
            underline = true,     -- Specify Underline diagnostics
            update_in_insert = false,  -- Keep diagnostics active in insert mode
        })


        -- Setup servers
        -- local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- Sem Mason: cada server só é habilitado se o binário existir no
        -- $PATH no momento em que o nvim abre. Ferramentas de editor
        -- (lua-language-server) vêm de home.nix, globais. Ferramentas de
        -- projeto (gopls, ruby-lsp, etc.) vêm do shell.nix de cada projeto,
        -- carregado via direnv — assim abrir o nvim fora de um projeto
        -- nunca tenta subir um LSP que não existe ali.

        -- lua_ls: ferramenta de editor, pacote nixpkgs global
        vim.lsp.config('lua_ls', {
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
              workspace = {
                library = {
                  [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                  [vim.fn.stdpath("config") .. "/lua"] = true,
                },
              },
            },
          },
        })
        -- ruby_lsp: vem do shell.nix do projeto (ruby + bundler + gem ruby-lsp)
        vim.lsp.config('ruby_lsp', {
          capabilities = capabilities,
          cmd = { "ruby-lsp" },
          root_dir = vim.fs.root(0, { "Gemfile", ".git" }),
        })

        -- gopls: vem do shell.nix do projeto (go + gopls)
        vim.lsp.config('gopls', {
          capabilities = capabilities
        })

        if vim.fn.executable("lua-language-server") == 1 then
          vim.lsp.enable('lua_ls')
        end
        if vim.fn.executable("ruby-lsp") == 1 then
          vim.lsp.enable('ruby_lsp')
        end
        if vim.fn.executable("gopls") == 1 then
          vim.lsp.enable('gopls')
        end
    end,
}
