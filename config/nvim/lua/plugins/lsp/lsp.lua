return {

    -- ───────────────────────────────────
    --  Neovim ネイティブ LSP ＋ Mason
    -- ───────────────────────────────────
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            { "williamboman/mason.nvim",           config = true },
            { "williamboman/mason-lspconfig.nvim", config = true },
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/vim-vsnip",
            "hrsh7th/vim-vsnip-integ",
            "hrsh7th/cmp-vsnip",
        },
        config = function()
            --------------------------------------------------------------------------
            -- Mason
            --------------------------------------------------------------------------
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "pyright",
                    "ts_ls",
                    "clangd",
                    "rust_analyzer",
                },
                automatic_installation = true,
            })

            --------------------------------------------------------------------------
            -- LSP capabilities
            --------------------------------------------------------------------------
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            --------------------------------------------------------------------------
            -- Diagnostic 設定
            --------------------------------------------------------------------------
            vim.diagnostic.config({
                virtual_text     = true,
                signs            = true,
                underline        = true,
                update_in_insert = false,
                severity_sort    = true,
            })

            --------------------------------------------------------------------------
            -- LuaLS だけ追加設定
            --------------------------------------------------------------------------
            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace   = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry   = { enable = false },
                    },
                },
            })

            --------------------------------------------------------------------------
            -- サーバー有効化
            --------------------------------------------------------------------------
            vim.lsp.enable({
                "lua_ls",
                "pyright",
                "ts_ls",
                "clangd",
                "rust_analyzer",
            })

            --------------------------------------------------------------------------
            -- LspAttach: キーマップ & Inlay Hint
            --------------------------------------------------------------------------
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP 接続時共通設定",
                callback = function(ev)
                    local bufnr = ev.buf
                    local opts  = { buffer = bufnr, silent = true }

                    -- ジャンプ／アクション
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)

                    -- フォーマット (Normal: バッファ全体, Visual: 選択範囲)
                    vim.keymap.set("n", "<leader>=", function()
                        vim.lsp.buf.format({ async = true })
                    end, opts)

                    vim.keymap.set("v", "<leader>=", function()
                        -- ビジュアル選択の範囲を取得
                        local start_pos = vim.fn.getpos("'<")
                        local end_pos   = vim.fn.getpos("'>")
                        vim.lsp.buf.format({
                            async = true,
                            range = {
                                ["start"] = { start_pos[2] - 1, start_pos[3] - 1 },
                                ["end"]   = { end_pos[2] - 1, end_pos[3] - 1 },
                            },
                        })
                    end, opts)

                    -- Inlay Hint
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    if client.server_capabilities.inlayHintProvider then
                        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                    end
                end,
            })
        end,
    },

    -- ───────────────────────────────────
    --  nvim‑cmp
    -- ───────────────────────────────────
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/vim-vsnip",
            "hrsh7th/cmp-vsnip",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args) vim.fn["vsnip#anonymous"](args.body) end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"]     = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"]     = cmp.mapping.abort(),
                    ["<CR>"]      = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "vsnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        end,
    },

    -- ───────────────────────────────────
    --  Treesitter
    -- ───────────────────────────────────
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        build = ":TSUpdate",
        dependencies = { "windwp/nvim-ts-autotag" },
        config = function()
            require("nvim-treesitter.configs").setup({
                highlight        = { enable = true },
                indent           = { enable = true },
                autotag          = { enable = true },
                ensure_installed = {
                    "lua", "vim", "vimdoc", "c", "cpp", "python", "rust",
                    "typescript", "javascript", "html", "css", "json",
                    "yaml", "markdown", "markdown_inline", "bash", "go"
                },
                sync_install     = false,
                auto_install     = true,
            })
        end,
    },

    -- ───────────────────────────────────
    --  nvim‑autopairs
    -- ───────────────────────────────────
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({})
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp           = require("cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },
}
