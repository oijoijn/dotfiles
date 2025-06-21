return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*", -- または最新の安定版を指定
        build = "make install_jsregexp", -- 高速化のために推奨
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            local luasnip = require("luasnip")
            -- friendly-snippets をロード
            require("luasnip.loaders.from_vscode").lazy_load()

            -- 必要であれば、カスタムスニペットのパスも設定
            -- require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/custom-snippets" })

            -- スニペット展開やジャンプのキーマッピング例 (任意)
            -- <C-f> で展開/次へ、<C-b> で前へ などお好みで設定
            vim.keymap.set({"i", "s"}, "<C-f>", function()
                if luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                end
            end, {silent = true})
            vim.keymap.set({"i", "s"}, "<C-b>", function()
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                end
            end, {silent = true})
        end,
    }
}
