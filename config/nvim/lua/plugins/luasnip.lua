return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()
            vim.keymap.set({"i", "s"}, "<C-l>", function()
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
