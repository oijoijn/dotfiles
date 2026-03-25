return {
    {
        "folke/twilight.nvim",
        -- 起動時にすぐ有効にしたい場合、VeryLazyだと一瞬遅れることがあるため
        -- 気になる場合は "BufReadPost" などに変えても良いですが、通常はこれでも大丈夫です
        event = "VeryLazy",

        opts = {
            dimming = {
                alpha = 0.5,
            },
            -- 前回の設定（関数内のみフォーカス）を維持
            context = 0,
            treesitter = true,
            expand = {
                "function",
                "method",
                "table",
                "if_statement",
            },
        },

        -- ▼▼▼ ここが変更点です ▼▼▼
        config = function(_, opts)
            -- 1. 設定を読み込む
            require("twilight").setup(opts)
            
            -- 2. 起動時に強制的にオンにする
            require("twilight").enable()
        end,

        keys = {
            { "<leader>tt", "<cmd>Twilight<cr>", desc = "Toggle Twilight" },
        },
    }
}
