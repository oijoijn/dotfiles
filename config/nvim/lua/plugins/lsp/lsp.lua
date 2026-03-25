-- lsp.lua
return {
    -- ─────────────────────────────────────────────────────────────
    --  Lua LSP の型情報を強化（Neovim API の型ズレ警告を減らす）
    -- ─────────────────────────────────────────────────────────────
    {
        "folke/lazydev.nvim",
        ft = "lua",
        dependencies = {
            { "Bilal2453/luvit-meta", lazy = true },
        },
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },

    -- ─────────────────────────────────────────────────────────────
    --  Neovim LSP + Mason
    -- ─────────────────────────────────────────────────────────────
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local servers = {
                "lua_ls",
                "pyright",
                "eslint",
                "ts_ls",
                "clangd",
                "rust_analyzer",
            }

            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = servers,
                automatic_enable = false, -- 自分で vim.lsp.enable() する
            })

            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            vim.lsp.config("*", { capabilities = capabilities })

            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                            -- 設定ファイルで出やすいノイズを抑制（必要なら外してください）
                            disable = { "missing-fields" },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            })

            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })

            vim.lsp.enable(servers)

            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP attach keymaps",
                callback = function(ev)
                    local bufnr = ev.buf
                    local opts = { buffer = bufnr, silent = true }

                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

                    vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
                    vim.keymap.set("n", "]d", function()
                        vim.diagnostic.jump({ count = 1, float = true })
                        vim.cmd("normal! zz")
                    end, opts)
                    vim.keymap.set("n", "[d", function()
                        vim.diagnostic.jump({ count = -1, float = true })
                        vim.cmd("normal! zz")
                    end, opts)

                    vim.keymap.set("n", "<leader>=", function()
                        vim.lsp.buf.format({ async = true })
                    end, opts)

                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    if client and client.supports_method and client:supports_method("textDocument/inlayHint") then
                        if vim.lsp.inlay_hint and vim.lsp.inlay_hint.enable then
                            pcall(vim.lsp.inlay_hint.enable, true, { bufnr = bufnr })
                        end
                    end
                end,
            })
        end,
    },

    -- ─────────────────────────────────────────────────────────────
    --  nvim-cmp + LuaSnip（React の rfc を「確実に」入れる）
    -- ─────────────────────────────────────────────────────────────
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",

            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            vim.opt.completeopt = { "menu", "menuone", "noselect" }

            local cmp = require("cmp")
            local luasnip = require("luasnip")

            require("luasnip.loaders.from_vscode").lazy_load()

            -- rfc / rfce を自前定義（friendly-snippets 側の有無に依存しない）
            local s = luasnip.snippet
            local t = luasnip.text_node
            local i = luasnip.insert_node

            luasnip.add_snippets("typescriptreact", {
                s("rfc", {
                    t({ "export default function " }), i(1, "Component"), t({ "() {", "  return (", "    <div>" }),
                    i(0),
                    t({ "</div>", "  );", "}", "" }),
                }),
                s("rfce", {
                    t({ "const " }), i(1, "Component"), t({ " = () => {", "  return (", "    <div>" }),
                    i(0),
                    t({ "</div>", "  );", "};", "", "export default " }), i(1), t({ ";", "" }),
                }),
            })

            luasnip.add_snippets("javascriptreact", {
                s("rfc", {
                    t({ "export default function " }), i(1, "Component"), t({ "() {", "  return (", "    <div>" }),
                    i(0),
                    t({ "</div>", "  );", "}", "" }),
                }),
            })

            -- unpack を使わずに cursor 配列から取り出す（LuaLS の Deprecated 警告回避）
            local function has_words_before()
                local cursor = vim.api.nvim_win_get_cursor(0)
                local line = cursor[1]
                local col = cursor[2]
                if col == 0 then
                    return false
                end
                local current = (vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1] or "")
                return current:sub(col, col):match("%s") == nil
            end

            -- LuaLS が nvim-cmp の setup シグネチャを誤認する環境があるため、その行だけ抑制
            ---@diagnostic disable-next-line: redundant-parameter
            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),

                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "luasnip" },
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        end,
    },

    -- ─────────────────────────────────────────────────────────────
    --  TSX/JSX タグ自動閉じ
    -- ─────────────────────────────────────────────────────────────
    {
        "windwp/nvim-ts-autotag",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            opts = {
                enable_close = true,
                enable_rename = true,
                enable_close_on_slash = false,
            },
            -- 必要ならファイルタイプ別
            -- per_filetype = {
            --   ["html"] = { enable_close = false },
            -- },
        },
    },
    -- ─────────────────────────────────────────────────────────────
    --  Treesitter
    -- ─────────────────────────────────────────────────────────────
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        build = ":TSUpdate",
        opts = {
            modules = {},
            ignore_install = {},

            highlight = {
                enable = true,
                disable = { "vim", "vimdoc" },
            },
            indent = { enable = true },
            ensure_installed = {
                "vim", "vimdoc", "lua",
                "c", "cpp",
                "python",
                "rust",
                "typescript",
                "tsx",
                "javascript",
                "html", "css",
                "json", "yaml",
                "markdown", "markdown_inline",
                "bash", "go",
            },
            sync_install = false,
            auto_install = true,
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },

    -- ─────────────────────────────────────────────────────────────
    --  autopairs
    -- ─────────────────────────────────────────────────────────────
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        dependencies = { "hrsh7th/nvim-cmp" },
        config = function()
            require("nvim-autopairs").setup({})
            local cmp = require("cmp")
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },
}
